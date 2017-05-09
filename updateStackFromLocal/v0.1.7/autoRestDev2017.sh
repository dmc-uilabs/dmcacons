#!/bin/bash


cd /home/dmcdevelopment/Desktop/gitDMC/dmcrest/v0.1.7/dmcrestMaster/dmcrest


rm -fr target
echo "running a build in folder : "
pwd
mvn package -P swagger

cd /home/dmcdevelopment/dmc/dmcacons/updateStackFromLocal/v0.1.7
./updateStackRestFromLocalDev02v017.sh
