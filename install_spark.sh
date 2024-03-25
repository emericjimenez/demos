#chmod +x install_spark.sh
#!/bin/bash
DATASET="hold1.csv"
URL_DATASET="https://storage.googleapis.com/kaggle-data-sets/1993/3415/compressed/hold1.csv.zip?X-Goog-Algorithm=GOOG4-RSA-SHA256&X-Goog-Credential=gcp-kaggle-com%40kaggle-161607.iam.gserviceaccount.com%2F20240325%2Fauto%2Fstorage%2Fgoog4_request&X-Goog-Date=20240325T024209Z&X-Goog-Expires=259200&X-Goog-SignedHeaders=host&X-Goog-Signature=56a2c47d3aed7f7eb32799edaf3c4945d4f4e920a19b7a67a4a5c8a664f0a4324d00e220a35dcdaa6124bc2be48e04bb76efa98b77bcea400d70b9b41f8dddd28ab095f31751fc33b5226121fe6176c272486ebcc3652e4164cf21b18436afdbf3bd7cd8cc47db0169a10efb02860d3209dd715d0f31805a7d013faceee69368a799858caf2b0ba857506bc39763bfad9642b3c434f5be6c7142a02aeb292a73a255d31a986374a2603144b43258d97370b03340dca5424e535bc576d66f636c53596362d8e5e81a694daa1144c4c00f6f3e9a2d5b9312b7785bf4795bac9d4aee28f022d0881b5f4a1e1f9d7a3373d245e79e8a8d2d819114c1ed1cc3ad6287"
FILE_PY="proc.py"
FILE_DOWNLOAD="hold1.zip"

echo Install Unzip
sudo apt install -y unzip
echo Update!
sudo apt update
echo Install JDK!
sudo apt install -y default-jdk
echo Download spark!
wget https://dlcdn.apache.org/spark/spark-3.5.1/spark-3.5.1-bin-hadoop3.tgz
echo Tar Spark!
tar -xvf spark-3.5.1-bin-hadoop3.tgz
echo Move Spark!
sudo mv -f spark-3.5.1-bin-hadoop3/ /opt/spark
echo Update 2!
sudo apt-get update 
echo Export bashrc!
echo "export SPARK_HOME=/opt/spark" >> ~/.bashrc
echo "export PATH=$PATH:$SPARK_HOME/bin" >> ~/.bashrc
echo Source Bashrc!
source ~/.bashrc


echo Download Dataset
wget -O $FILE_DOWNLOAD $URL_DATASET
echo Unzip Dataset
unzip $FILE_DOWNLOAD
rm $FILE_DOWNLOAD
echo Move dataset
mkdir -p /opt/spark/datasets
mv -f $DATASET /opt/spark/datasets/$DATASET

cd /opt/spark/bin

echo "from pyspark.sql import SparkSession" >$FILE_PY
echo "logger = spark._jvm.org.apache.log4j" >$FILE_PY
echo "logger.LogManager.getLogger('org').setLevel(logger.Level.ERROR)" >$FILE_PY
echo "spark = SparkSession.builder \\" >>$FILE_PY
echo "    .appName('Lectura de Dataset') \\" >>$FILE_PY
echo "    .getOrCreate()" >>$FILE_PY
echo "df = spark.read.options(header='True', inferSchema='True').csv('/opt/spark/datasets/*.csv')" >>$FILE_PY
echo "print('Count 1: ', df.count())" >>$FILE_PY
echo "df.printSchema()" >>$FILE_PY
echo "df.select(['10th_avenue']).distinct().show()" >>$FILE_PY
echo "print('Count 2: ',df.where(df['10th_avenue']==3).select('12th_avenue', '5th_avenue').count())" >>$FILE_PY
echo "df.where(df['10th_avenue']==3).select('12th_avenue', '5th_avenue').show()" >>$FILE_PY

/opt/spark/bin/spark-submit $FILE_PY
