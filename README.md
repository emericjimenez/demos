# Script examples for automation

## basic_docker.sh ---> Basic Docker Example
## Test on a VPS with Ubuntu 22 or a Local Virtual Machine
- Download : wget https://raw.githubusercontent.com/emericjimenez/demos/main/basic_docker.sh
- Give permission: sudo chmod +x basic_docker.sh
- Execute: ./basic_docker.sh
- Install Docker
- Run 1 container with Apache and an example page in PHP.
- Run 1 container with uvicorn and a Python example using FastAPI to receive and return a response.
- ----------------->
![Basic Docker](https://github.com/emericjimenez/demos/blob/main/basic_docker.gif)

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
