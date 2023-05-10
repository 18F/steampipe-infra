#!/bin/sh

#Output color
GREEN='\033[0;32m'

#Build Docker image
docker build -t steampipe .

echo "${GREEN} Building docker image...."
mkdir -p $HOME/sp/config

# create a directory for the config files
DIR="$(pwd)"/report
if [ "$DIR" ]; then
  echo "${DIR} exists, skipping step..."
  rm -rf "$(pwd)"/report
else
  echo "Error: Directory not found. Creating one....."
  mkdir -p "$(pwd)"/report
fi

Str1="Waiting for docker image to be created....";
sleep 10
echo $Str1

echo "${GREEN} Attempting to run docker container....."

#Run Container
docker run --name steampipe -d steampipe:latest

# docker run \
#   -p 9193:9193 \
#   -d \
#   --name steampipe \
#   --mount type=bind,source=$HOME/sp/config,target=/home/steampipe/.steampipe2/config  \
#   --mount type=volume,source=steampipe_data,target=/home/steampipe/.steampipe2/db/14.2.0/data \
#   --mount type=volume,source=steampipe_internal,target=/home/steampipe/.steampipe2/internal \
#   --mount type=volume,source=steampipe_logs,target=/home/steampipe/.steampipe2/logs   \
#   --mount type=volume,source=steampipe_plugins,target=/home/steampipe/.steampipe2/plugins   \
#   --mount type=bind,source="$(pwd)"/report,target=/tmp/report \
#   steampipe service start --foreground 

Str2="Waiting for docker container to start....";
sleep 10
echo $Str2

echo "${GREEN} Please login into Azure...."
docker exec -it steampipe az login

#CD into compliance Directory
docker exec --workdir /workspace steampipe pwd
docker exec steampipe dir
# echo "${GREEN} Runing compliance check, please wait....."
# docker exec -it steampipe steampipe check azure_compliance.benchmark.nist_sp_800_53_rev_5_sc_8 --export=output.csv --export=output.json

# #Export Output
# echo "${GREEN} Exporting report to mounted volume....."
# docker exec steampipe mv /workspace/output.csv /tmp/report/output-$(date +"%Y%m%d-%H%M%S").csv
# docker exec steampipe mv /workspace/output.json /tmp/report/output-$(date +"%Y%m%d-%H%M%S").json




