FROM python:3.9

RUN apt-get install wget
RUN pip install polars pandas sqlalchemy psycopg2 pyarrow

WORKDIR /app

COPY ingest_nyc_data_to_postgres.py ingest_nyc_data_to_postgres.py

ENTRYPOINT [ "python", "ingest_nyc_data_to_postgres.py"]