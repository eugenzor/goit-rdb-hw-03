from pathlib import Path

import pandas as pd
import pgserver
import sqlparse
from sqlalchemy import create_engine, make_url, text

BASE_DIR = Path(__file__).parent
SQL_DIR = BASE_DIR / "sql"
DATA_DIR = BASE_DIR / "data"
PG_DATA_DIR = BASE_DIR / ".pg_data"

csv_path = DATA_DIR / "hw3_adult.csv"

columns = [
    "age", "workclass", "fnlwgt", "education", "education_num",
    "marital_status", "occupation", "relationship", "race", "sex",
    "capital_gain", "capital_loss", "hours_per_week", "native_country", "income"
]

STEPS = [
    ("Очищені дані: DDL", "02_clean_schema.sql"),
    ("Очищені дані: перенесення зі staging", "03_clean_insert.sql"),
    ("Контроль кількості рядків", "04_row_count.sql"),
    ("Перевірка дублікатів", "05_duplicates.sql"),
    ("Null-rate і спеціальні маркери", "06_null_markers.sql"),
    ("Null-rate після очищення", "07_null_rate_clean.sql"),
    ("Розподіл категоріальної колонки", "08_workclass_distribution.sql"),
    ("Базова статистика числових колонок", "09_numeric_stats.sql"),
    ("Outlier-check", "10_outliers.sql"),
    ("EDA: частка доходу понад 50K", "11_income_share.sql"),
    ("EDA: дохід за рівнем освіти", "12_income_by_education.sql"),
    ("EDA: пропуски у train і test", "13_missing_by_split.sql"),
    ("EDA: дохід за робочими годинами", "14_income_by_hours.sql"),
    ("EDA: найбільше робочих годин", "15_long_hours_examples.sql"),
    ("EDA: професії tech/craft", "16_tech_craft_occupations.sql"),
    ("EDA: рідкісні країни походження", "17_rare_countries.sql"),
    ("EDA: education і education_num", "18_education_codes.sql"),
    ("EDA: професії та заробіток", "19_occupation_income.sql"),
    ("EDA: capital_gain / capital_loss", "20_capital_groups.sql"),
]


def run_sql(engine, sql: str):
    with engine.begin() as conn:
        for statement in sqlparse.split(sql):
            statement = statement.strip()
            if not statement:
                continue
            result = conn.execute(text(statement))
            if result.returns_rows:
                df = pd.DataFrame(result.fetchall(), columns=result.keys())
                print(df.to_string())
            else:
                print(f"OK: {result.rowcount} rows")


def read_uci_file(filename: str, skiprows: int = 0) -> pd.DataFrame:
    return pd.read_csv(
        DATA_DIR / filename,
        header=None,
        names=columns,
        dtype=str,
        na_filter=False,
        skiprows=skiprows,
        skip_blank_lines=True
    )


def prepare_csv():
    train = read_uci_file("adult.data")
    test = read_uci_file("adult.test", skiprows=1)

    assert len(train) == 32561, f"Неочікувана кількість train: {len(train)}"
    assert len(test) == 16281, f"Неочікувана кількість test: {len(test)}"

    train.insert(0, "source_row", range(1, len(train) + 1))
    train.insert(0, "source_split", "train")
    test.insert(0, "source_row", range(1, len(test) + 1))
    test.insert(0, "source_split", "test")

    df = pd.concat([train, test], ignore_index=True)
    assert df.shape == (48842, 17), f"Неочікувана схема: {df.shape}"

    df.to_csv(csv_path, index=False, encoding="utf-8")
    print("Джерело:", DATA_DIR / "adult.data", DATA_DIR / "adult.test")
    print("CSV:", csv_path)
    print("Рядків (train/test/разом):", len(train), len(test), len(df))
    print("Поля CSV:", list(df.columns))
    print(df)


def load_staging(engine):
    raw_conn = engine.raw_connection()
    try:
        with (
            raw_conn.cursor() as cur,
            open(csv_path, "r", encoding="utf-8", newline="") as file,
        ):
            cur.copy_expert(
                r"""
                COPY hw3_adult_staging (
                    source_split_raw, source_row_raw, age_raw,
                    workclass_raw, fnlwgt_raw, education_raw, education_num_raw,
                    marital_status_raw, occupation_raw, relationship_raw,
                    race_raw, sex_raw, capital_gain_raw, capital_loss_raw,
                    hours_per_week_raw, native_country_raw, income_raw
                )
                FROM STDIN
                WITH (
                    FORMAT csv,
                    HEADER true,
                    DELIMITER ',',
                    NULL '__PG_NULL__',
                    ENCODING 'UTF8'
                )
                """,
                file
            )
        raw_conn.commit()
    except Exception:
        raw_conn.rollback()
        raise
    finally:
        raw_conn.close()

    run_sql(engine, "SELECT COUNT(*) AS staging_rows FROM hw3_adult_staging;")


def main():
    pg = pgserver.get_server(PG_DATA_DIR)
    # SQLAlchemy 2.1+ defaults to psycopg 3, the project uses psycopg2 (copy_expert)
    url = make_url(pg.get_uri()).set(drivername="postgresql+psycopg2")
    engine = create_engine(url)
    try:
        print("\n=== Перевірка підключення ===")
        run_sql(engine, "SELECT version() AS postgres_version;")

        print("\n=== Підготовка CSV з data/ ===")
        prepare_csv()

        print("\n=== Staging: DDL (01_staging_schema.sql) ===")
        run_sql(engine, (SQL_DIR / "01_staging_schema.sql").read_text(encoding="utf-8"))

        print("\n=== Staging: COPY з CSV ===")
        load_staging(engine)

        for title, filename in STEPS:
            print(f"\n=== {title} ({filename}) ===")
            run_sql(engine, (SQL_DIR / filename).read_text(encoding="utf-8"))
    finally:
        engine.dispose()
        pg.cleanup()


if __name__ == "__main__":
    main()
