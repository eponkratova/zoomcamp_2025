import pandas as pd
from sqlalchemy import create_engine
import argparse
import requests

def main(params):
    user = params.user
    password = params.password
    host = params.host
    db = params.db
    port = params.port
    table_name = params.table_name
    url = params.url
    csv_name = 'output.csv'

    # Download the CSV file using requests
    response = requests.get(url)
    with open(csv_name, 'wb') as f:
        f.write(response.content)

    # Read the CSV into a DataFrame
    df = pd.read_csv(csv_name)
    #df['lpep_pickup_datetime'] = pd.to_datetime(df['lpep_pickup_datetime'])
    #df['lpep_dropoff_datetime'] = pd.to_datetime(df['lpep_dropoff_datetime'])

    # Connect to the PostgreSQL database
    engine = create_engine(f'postgresql://{user}:{password}@{host}:{port}/{db}')

    # Print schema and ingest data
    print(pd.io.sql.get_schema(df, name=table_name, con=engine))
    df.to_sql(name=table_name, con=engine, if_exists='replace')


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Please ingest csv")
    parser.add_argument('--user', help='user name')
    parser.add_argument('--password', help='password')
    parser.add_argument('--host', help='host')
    parser.add_argument('--port', help='port')
    parser.add_argument('--db', help='database name')
    parser.add_argument('--table_name', help='table name')
    parser.add_argument('--url', help='csv url')

    args = parser.parse_args()
    main(args)
