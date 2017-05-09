#!/bin/bash


cd /home/dmcdevelopment/Desktop/gitDMC/dmcfront/v0.1.8/dmcfrontMaster/dmcfront


rm -fr dist
echo "running a build in folder : "
pwd
gulp build

cd /home/dmcdevelopment/dmc/dmcacons/updateStackFromLocal/v0.1.8
./updateStackFrontFromLocalBeta-v018.sh
