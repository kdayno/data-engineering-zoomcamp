import os
import argparse

import polars as pl
import pyarrow

from sqlalchemy import create_engine
from time import time

def main(params):
    user = params.user
    password = params.password
    host = params.host
    port = params.port
    db = params.db
    table_name = params.table_name
    url = params.url
    source_file_name = 'output.parquet'

    # download the csv
    os.system(f'wget {url} -O {source_file_name}')

    engine = create_engine(f'postgresql://{user}:{password}@{host}:{port}/{db}')
    engine.connect()

    df = pl.read_parquet(f'{source_file_name}', use_pyarrow=True)

    df.head(0).write_database(table_name=f'{table_name}', connection=engine.url, engine='sqlalchemy')

    df_iter = df.iter_slices(n_rows=200000)

    while True:

        t_start = time()
        
        df = next(df_iter)
    
        df.write_database(table_name=f'{table_name}', connection=engine.url, engine='sqlalchemy', if_table_exists='replace')
        
        t_end = time()

        print('Inserted another chunk... Duration: %.3f seconds' % (t_end - t_start)) 

if __name__=='__main__':

    parser = argparse.ArgumentParser(description='Ingest Parquet data to Postgres')

    parser.add_argument('--user', help='user for postgres')
    parser.add_argument('--password', help='password for postgres')
    parser.add_argument('--host', help='host for postgres')
    parser.add_argument('--port', help='port for postgres')
    parser.add_argument('--db', help='database name for postgres')
    parser.add_argument('--table-name', help='name of the table where we will write the results')
    parser.add_argument('--url', help='url of the csv file')

    args = parser.parse_args()
    
    main(args)
