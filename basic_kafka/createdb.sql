
CREATE SCHEMA csv01;

CREATE TABLE csv01.csv (
  id SERIAL PRIMARY KEY,
  date_data timestamp with time zone NOT NULL,
  model VARCHAR(255) NOT NULL,
  year INT NOT NULL,
  price DECIMAL(10,2) NOT NULL,
  transmission VARCHAR(50) NOT NULL,
  mileage INT NOT NULL,
  fuelType VARCHAR(50) NOT NULL,
  tax DECIMAL(10,2) NOT NULL,
  mpg FLOAT NOT NULL,
  engineSize DECIMAL(5,2) NOT NULL
);


SELECT COUNT(*) FROM csv01.csv;
select * from csv01.csv limit 10
