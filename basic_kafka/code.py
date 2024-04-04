import datetime
import json
import logging
from kafka import KafkaConsumer
import psycopg2
from datetime import datetime

def store_data(date_data, model,year,price,transmission,mileage,fuelType,tax,mpg,engineSize):
    sql = """
    INSERT INTO csv01.csv(date_data, model,year,price,transmission,mileage,fuelType,tax,mpg,engineSize) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s);
    """

    with psycopg2.connect(
        database="postgresdb",
        host="127.0.0.1",
        user="postgres",
        password="postgres",
        port="5432",
    ) as conn:
        cur = conn.cursor()
        try:
            cur.execute(sql, (date_data, model,year,price,transmission,mileage,fuelType,tax,mpg,engineSize))
            conn.commit()
        except Exception as e:
            logging.error(f"Error storing CSV: {e}")


consumer = KafkaConsumer(
    group_id="csv-group",
    bootstrap_servers=["127.0.0.1:29092"],
    value_deserializer=lambda x: json.loads(x.decode("utf-8")),
)

consumer.subscribe(topics=["csv01"])
for msg in consumer:
    try:
        data = msg.value['log'].split(",")
        model=data[0]
        year=data[1]
        price=data[2]
        transmission=data[3]
        mileage=data[4]
        fuelType=data[5]
        tax=data[6]
        mpg=data[7]
        engineSize=data[8]
        date_now = datetime.fromtimestamp(msg.value['@timestamp'])
        date_data = date_now.strftime('%Y-%m-%d %H:%M:%S')
        store_data(date_data, model,year,price,transmission,mileage,fuelType,tax,mpg,engineSize)
    except IndexError:
      print("***Bad Index****")
consumer.close()
