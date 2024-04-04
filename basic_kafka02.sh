#!/bin/bash
killall python3 "$dir_kafka/$code_py"
python3 "$dir_kafka/$code_py" &
sleep 2
killall python3 "$dir_kafka/$code_py"
python3 "$dir_kafka/$code_py" &

primera_ip=$(hostname -I | cut -d ' ' -f 1)
echo "Cloudbeaver: http://$primera_ip:8080"

code_py="code.py"
url_ds_1="https://storage.googleapis.com/kagglesdsdata/datasets/750216/1305559/audi.csv?X-Goog-Algorithm=GOOG4-RSA-SHA256&X-Goog-Credential=gcp-kaggle-com%40kaggle-161607.iam.gserviceaccount.com%2F20240402%2Fauto%2Fstorage%2Fgoog4_request&X-Goog-Date=20240402T093119Z&X-Goog-Expires=259200&X-Goog-SignedHeaders=host&X-Goog-Signature=8ffd0126cd4e456a31e4fc7089001cffee12da4a71b683eb5150c087f89e7536464e420e51d138572b59bc5f86d47ddf7c511840e14ca69c4235fd83e5b0433f7a8d7dc719fe9f2476d262e1aa9626e793ebe38fc3d3e0c8bd47ecf652475beaeccf4c390ddd5233b9c9aa0674b617e5b513ed37d7ea1b25b6a4edd20de11e57e1d13c03ebb6f940c943f70c8b977a0bc897491dc89e7191133126c09ea2ee5ada1aa1f826a9041d35264603e93bd4a7d2894abbc8b742215eb31ad3160e80c2d5a8294307456c3d76316befa1053ab4071211bfe975a996062f8496889bb11b7ab5a6ac3ecac51548b0376265b3a3232fafe736938f246e001ede23da893102"
url_ds_2="https://storage.googleapis.com/kagglesdsdata/datasets/750216/1305559/bmw.csv?X-Goog-Algorithm=GOOG4-RSA-SHA256&X-Goog-Credential=gcp-kaggle-com%40kaggle-161607.iam.gserviceaccount.com%2F20240402%2Fauto%2Fstorage%2Fgoog4_request&X-Goog-Date=20240402T093127Z&X-Goog-Expires=259200&X-Goog-SignedHeaders=host&X-Goog-Signature=59b42321fe064f68c4d6218138885d7e880afe1e793ffffb6a9bca340de72ef43e7f34a1509d03d4c32534c70e7ddae214181e683dace48eaabe79beea84d2c27923cc5aba332336280ca498c81b1e926c4b39a4b04170f33d8bf217755d7102a69039674b52af725ef1c940c7a23b52a7397732b2e13125501315f1ac9320ea246eec3fb2d2e8d2df8ac76a2ab758baf8211d35dafed099f224d22cc42a35b8a6fe91d3e96010a6e1f3847dec85df37472c1f278154e4e8928fedf68f9b94d04a52272bbb780a2048394b111cda59b8b99ab42c643badae8c1ac6cbe55df917c64975c1b5632f7482910d46838a1b17b6578db9756f5005050a21c9d85d414b"
url_ds_3="https://storage.googleapis.com/kagglesdsdata/datasets/750216/1305559/cclass.csv?X-Goog-Algorithm=GOOG4-RSA-SHA256&X-Goog-Credential=gcp-kaggle-com%40kaggle-161607.iam.gserviceaccount.com%2F20240402%2Fauto%2Fstorage%2Fgoog4_request&X-Goog-Date=20240402T093134Z&X-Goog-Expires=259200&X-Goog-SignedHeaders=host&X-Goog-Signature=a00eb32205b262131adfae556bd34892f091259445dae285ecef60122cae13690227af7bca7e082442fcfd259b32406fcfdfb67e1948c4ed384180b1af586d39a79c8873aaf5db473f8240f77bd43b8c14cdde1771ce35aeea7b6b8239f6a2e87ea3ab02fbf31a379f6fec7ad44ef46ae3b176232d39433416d6a4c94963eb1e836fe0db5489456421771a91d025cacdcd1cafd9aa8ecdf4a5ee27cded22318910e58cf733fc4f024e22382c1fa38b64a22791bd2b3a3b5bc6851d5552736fd419ee734faa8ee9b200ccc6eb3fc0988e71085a1f1667357e30d8cedd1b8273fa8f1bf31d390b83fb01e20af3de19ba4f7d590af67c48bf2db661a542415fd7f2"
url_ds_4="https://storage.googleapis.com/kagglesdsdata/datasets/750216/1305559/focus.csv?X-Goog-Algorithm=GOOG4-RSA-SHA256&X-Goog-Credential=gcp-kaggle-com%40kaggle-161607.iam.gserviceaccount.com%2F20240402%2Fauto%2Fstorage%2Fgoog4_request&X-Goog-Date=20240402T093137Z&X-Goog-Expires=259200&X-Goog-SignedHeaders=host&X-Goog-Signature=98c48c2a8712574f370c565917812af4b7563ab39c1c355f81600afdf17236c0e6b9c5dedbe993c2903b36a7a249d63919805016e40dda449c217c96aa50999ee850ecb79f3ffa57f3981744296403737825514f99cb0f4cf24b6b490c70956d7ad97757848240e6f797fc873ca63052f43e72b601e13493c21f4f10cf97026b010b5231b581d16396459683de549dbf5b97390024d4a2a694fc841cb3abaca2fb711b9633c9e8e9d8f00b39bbdb2ffafc829c26656191055cd6478a33cf5e758b8fafc235bffbd4f5f7b41a0812ddbc0637daefa7556420fc5b1ef8856fea76d26da7f5e71c1eabe6531a729271cc3d58c7fa2ddacfc4ffb01a3c199cf2ea5d"
url_ds_5="https://storage.googleapis.com/kagglesdsdata/datasets/750216/1305559/ford.csv?X-Goog-Algorithm=GOOG4-RSA-SHA256&X-Goog-Credential=gcp-kaggle-com%40kaggle-161607.iam.gserviceaccount.com%2F20240402%2Fauto%2Fstorage%2Fgoog4_request&X-Goog-Date=20240402T093142Z&X-Goog-Expires=259200&X-Goog-SignedHeaders=host&X-Goog-Signature=019041317254ecf56540da6b86a47844de6d634e3cc44b159bfebcccf4819300444030f2528af712433bc0cd3584d0197df47c97ffaded791bfd20094157b0a09d4978859e90268cfce99f639b2db78eab89496f01524c2c9a22982f027d23347acb393ceb9f23ef6306e450d3c9bfcc8df051cabf6e56ada60bf99f747747f65d5d1efce046d52bc3cd6536466b387df8d4d9cc51080550db56bec2b36e40343924b742f3cd5e5bb3c4ff4304cd6d48159b16cb822a1f0f9e3fbbd65f4ac6ce5c039a4335889a54952efa10e2ec7c3e8da8c792b3596fe5f122d09d761ba5e212876701c80173f54d7ba0c7862bca2b2d09970d645345645e7d1a389a7d2c00"


ds_00="ds0.csv"
ds_01="ds1.csv"
ds_02="ds2.csv"
ds_03="ds3.csv"
ds_04="ds4.csv"
ds_05="ds5.csv"
dir_kafka=~/kafka

function file_exist() {
  if test -f "$1"; then
    return 0
  else
    return 1
  fi
}

function wget_download() {
  wget -O "$1" "$2" &
}

cd $dir_kafka
echo Downloads!
wget_download $ds_01 $url_ds_1
wget_download $ds_02 $url_ds_2
wget_download $ds_03 $url_ds_3
#wget_download $ds_04 $url_ds_4
#wget_download $ds_05 $url_ds_5


while true; do
  files_csv=$(ls -1 "$dir_kafka"/*.csv)
  for file_csv in $files_csv; do
    if [[ $file_csv != "$dir_kafka/$ds_00" ]]; then
      echo "Procesando"
      echo "$file_csv"
      sed '1d' $file_csv > $ds_00
      rm -f $file_csv
      /opt/fluent-bit/bin/fluent-bit -c ./fluent-bit.conf
      #rm -f $ds_00
    fi
  done
done

