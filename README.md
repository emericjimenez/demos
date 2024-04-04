# ----> Script examples for automation <----
# 1.- Basic example to create pipelines
## In this example for .csv files, it can be used in many ways, from IoT platforms to log collection.
## basic_kafka01.sh --> Create the environment and then cloudbeaver should be configured for the database.
## basic_kafka02.sh --> Checks for new .csv files in the folder and processes them.
## code.py It is responsible for sending the data to postgresql.
- Video: ![Download Video](https://raw.githubusercontent.com/emericjimenez/demos/main/basic_kafka/basic_kafka.mp4)
- There will be 3 terminals connected to your VPS or your Virtual Machine with Ubuntu 22 via SSH.
- Download 1 : wget https://raw.githubusercontent.com/emericjimenez/demos/main/basic_kafka01.sh
- Download 2 : wget https://raw.githubusercontent.com/emericjimenez/demos/main/basic_kafka02.sh
- Give permission: sudo chmod +x basic_kafka01.sh
- Give permission: sudo chmod +x basic_kafka02.sh
- 1st terminal --> Execute: ./basic_kafka01.sh
- Wait and when it finishes configure cloudbeaver with the following parameters:
-- Cloudbeaver set admin and password (your data).
-- Create a new connection for postgresql (example in the video).
-- Set postgresql--> database = postgresdb, host, user and password = postgres (example in the video).
-- Create schema and table from createdb.sql file (example in the video).
- 2nd terminal --> execute this code: python3 kafka/code.py (example in the video).
- 3rd terminal --> Execute: ./basic_kafka02.sh (example in the video).
- Please wait and then check cloudbeaver for the new data.
- Run 1 container with zookeeper, kafka, postgres and cloudbeaver.
- Run 2 run script python and send the new data to postgresql.
- Run 3 monitor changes and when found run Fluent Bit to process the new data.

![Basic Kafka](https://github.com/emericjimenez/demos/blob/main/basic_kafka.gif)

# 2.- Basic Docker Example (PHP <-> FastAPI) 
## basic_docker.sh ---> Basic Docker Example
## Test on a VPS with Ubuntu 22 or a Local Virtual Machine
- Download : wget https://raw.githubusercontent.com/emericjimenez/demos/main/basic_docker.sh
- Give permission: sudo chmod +x basic_docker.sh
- Execute: ./basic_docker.sh
- Install Docker
- Run 1 container with Apache and an example page in PHP.
- Run 2 container with uvicorn and a Python example using FastAPI to receive and return a response.
- ----------------->
![Basic Docker](https://github.com/emericjimenez/demos/blob/main/basic_docker.gif)

# 3.- Basic Spark Example
## install_spark.sh ---> Big Data example with Spark
## Test on a VPS with Ubuntu 22 or a Local Virtual Machine
- Download : wget -O install_spark.sh https://raw.githubusercontent.com/emericjimenez/demos/main/install_spark.sh
- Give permission: chmod +x install_spark.sh
- Execute: ./install_spark.sh
- Tested on Ubuntu 22.
- Install Spark and dependencies.
- Download a medium Dataset.
- Unzip and move to Spark directory.
- Create a Python Script that will display the Dataset.
- Run the Script in the Spark environment.
- Schemes, filtering of results and a select for 2 columns are shown regarding the filter used.
- ----------------->
![Install Spark](https://github.com/emericjimenez/demos/blob/main/install_spark.gif)
