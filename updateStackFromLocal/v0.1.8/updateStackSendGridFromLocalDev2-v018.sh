#!/bin/bash

#location of the email scripts folder
sendFile="/home/dmcdevelopment/Desktop/gitDMC/dmcEmail/v0.1.8/dmcEmailMaster/dmcEmail/routes"

#key for frontend machine
front_ssh_keyC="/home/dmcdevelopment/Desktop/keys/portalAzure/v0.1.3/web2v03132017"
#front machine user do not chnage for aws
front_userC=dmcAdmin
#ip of frontend machine
front_hostC="13.84.48.110"

scpSend() {
   timestamp=`date --rfc-3339=seconds`
    echo "Version created $timestamp" > "DeployedVersion.txt";
    echo "Navigating to the email folder at the following location "$sendFile
    scp -i $front_ssh_keyC -r DeployedVersion.txt $front_userC@$front_hostC:~
    scp -i $front_ssh_keyC -r $sendFile $front_userC@$front_hostC:~


    updateEmail
}

updateEmail() {
  ssh -tti $front_ssh_keyC $front_userC@$front_hostC <<+
    printf "Updating email Code Base"

     cd /opt/dmcEmail
     rm -rf routes
     cp -r ~/routes .

    exit

+
}

scpSend
echo "done updating Email-- back on local and done :)"
