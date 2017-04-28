#!/bin/bash


#location of the dist folder after created locally with gulp build
sendFile="/home/dmcdevelopment/Desktop/gitDMC/dmcrest/v0.1.3/dmcrest/target/dmc-site-services-0.1.0-swagger.war"

#key for frontend machine
rest_ssh_keyC="/home/dmcdevelopment/Desktop/keys/portalAzure/v0.1.3/azu03062017v1"
#front machine user do not chnage for aws
rest_userC=dmcAdmin
#ip of frontend machine
rest_hostC="40.70.69.190"



scpSend() {
   timestamp=`date --rfc-3339=seconds`
    echo "Version created $timestamp" > "DeployedVersion.txt";
    echo scp -v -i $rest_ssh_keyC -r DeployedVersion.txt $rest_userC@$rest_hostC:

    scp  -i $rest_ssh_keyC -r DeployedVersion.txt $rest_userC@$rest_hostC:
    scp  -i $rest_ssh_keyC -r $sendFile $rest_userC@$rest_hostC:
    updaterest
}

updaterest() {
  ssh -tti $rest_ssh_keyC $rest_userC@$rest_hostC <<+
    printf "Updating restend Code Base"
    # sudo yum update -y


   echo "value of rest_deploy_commit is $rest_deploy_commit"

   sudo systemctl stop tomcat

  cd ~
   #changing the names of the war files
   mv dmc-site-services-0.1.0-swagger.war rest.war
   #removing the old war deploymnet
   sudo rm -rf  /var/lib/tomcat/webapps/rest*
   #adding the new war deploymnet
   sudo -S cp rest.war /var/lib/tomcat/webapps
   sudo systemctl start tomcat

    exit

+
}

scpSend
echo "done updating -- back on local and done :)"
