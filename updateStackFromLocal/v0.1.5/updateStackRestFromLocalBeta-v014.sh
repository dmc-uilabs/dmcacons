#!/bin/bash


#location of the dist folder after created locally with gulp build
sendFile="/home/t/Desktop/gitDMC/dmcrest/v0.1.4/dmcrest/target/dmc-site-services-0.1.0-swagger.war"

#key for frontend machine
rest_ssh_keyC="/home/t/Desktop/keys/portalAzure/v0.1.4/betav03212017"
#front machine user do not chnage for aws
rest_userC=dmcAdmin
#ip of frontend machine
rest_hostC="52.173.137.186"



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
  timestamp=`date --rfc-3339=seconds`
   sudo cp  /var/lib/tomcat/webapps/rest.war  $timestamp.rest.war
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
