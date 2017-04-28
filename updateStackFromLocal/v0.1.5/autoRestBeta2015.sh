#!/bin/bash


cd /home/dmcdevelopment/Desktop/gitDMC/dmcrest/v0.1.5/dmcrestMaster/dmcrest


rm -fr target
echo "running a build in folder : "
pwd
mvn package -P swagger

cd /home/dmcdevelopment/Desktop/gitDMC/dmcacons/updateStackFromLocal/v0.1.5
./updateStackRestFromLocalBetav015
