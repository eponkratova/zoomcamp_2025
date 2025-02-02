#1st exercise:

# FROM python:3.12.8

# RUN pip install pandas

# ENTRYPOINT ["bash"]

#2nd exercise:

# FROM python:3.9 

# RUN pip install pandas

# WORKDIR /app 

# COPY pipeline.py pipeline.py 

# ENTRYPOINT ["bash"]

#3rd exercise:

FROM python:3.9

RUN apt-get install wget

RUN pip install pandas sqlalchemy psycopg2 requests

WORKDIR /app 

COPY importing_taxi_data.py importing_taxi_data.py 

ENTRYPOINT ["python", "importing_taxi_data.py"]