#!/bin/bash


cd /home/t/Desktop/gitDMC/dmcfront/v0.1.5/dmcfrontMaster/dmcfront


rm -fr dist
echo "running a build in folder : "
pwd
gulp build

cd /home/t/Desktop/gitDMC/dmcacons/updateStackFromLocal/v0.1.5
./updateStackFrontFromLocalDev2-v015.sh
