#!/bin/bash


cd /home/dmcdevelopment/Desktop/gitDMC/dmcfront/v0.1.4/dmcfront

rm -fr dist
echo "running a build in folder : "
pwd
gulp build

cd /home/dmcdevelopment/Desktop/gitDMC/dmcacons/updateStackFromLocal/v0.1.4
echo "running a following deplopyment script  : ./updateStackFrontFromLocalBeta-v014.sh"
./updateStackFrontFromLocalBeta-v014.sh
