#!/bin/bash


cd /home/dmcdevelopment/Desktop/gitDMC/dmcfront/v0.1.5/dmcfrontMaster/dmcfront


rm -fr dist
echo "running a build in folder : "
pwd
gulp build

cd /home/dmcdevelopment/Desktop/gitDMC/dmcacons/updateStackFromLocal/v0.1.5
echo "running a following deplopyment script  : ./updateStackFrontFromLocalBeta-v015.sh"
./updateStackFrontFromLocalBeta-v015.sh
