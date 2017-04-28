#!/bin/bash




#location of the dist folder after created locally with gulp build
sendFile="/home/dmcdevelopment/Desktop/gitDMC/dmcfront/v0.1.3/dmcfront/dist/"
#key for frontend machine
front_ssh_keyC="/home/dmcdevelopment/Desktop/keys/portalAzure/v0.1.3/azu02132017v1"
#front machine user do not chnage for aws
front_userC=dmcAdmin
#ip of frontend machine
front_hostC="40.69.163.95"
serverURL="dev-web2.opendmc.org"


scpSend() {
   timestamp=`date --rfc-3339=seconds`
    echo "Version created $timestamp" > "DeployedVersion.txt";
    scp -i $front_ssh_keyC -r DeployedVersion.txt $front_userC@$front_hostC:~
    scp -i $front_ssh_keyC -r $sendFile $front_userC@$front_hostC:~


    updateFront
}

updateFront() {
  ssh -tti $front_ssh_keyC $front_userC@$front_hostC <<+
    printf "Updating frontend Code Base"
    # sudo yum update -y

     cd /tmp
     rm -rf dist
     cp -r ~/dist .
    # unzip *.zip
    # #code is now in /tmp/rando/dist
    #
    #
    #update the loginURL
    cd /tmp/dist/templates/common/header
    echo "setting the login url -- serverURL is =$serverURL"
    if [ $serverURL == "beta.opendmc.org" || $serverURL == "portal.opendmc.org" ]
     then
       sed -i.bak "s|loginURL|https://apps.cirrusidentity.com/console/ds/index?entityID=https://beta/shibboleth\&return=https://$serverURL/Shibboleth.sso/Login%3Ftarget%3Dhttps%3A%2F%2F$serverURL|" header-tpl.html
     else

        sed -i.bak "s|loginURL|https://apps.cirrusidentity.com/console/ds/index?entityID=https://dev-web1.opendmc.org/shibboleth\&return=https://$serverURL/Shibboleth.sso/Login%3Ftarget%3Dhttps%3A%2F%2F$serverURL|" header-tpl.html
    fi


    # #update the windowApiUrl
    cd /tmp/dist/

    sed -i.bak "s|window.apiUrl = '';|window.apiUrl='https://$serverURL/rest'|" *.php

    ## update the version
    cd templates/common/footer
    timestamp=`date --rfc-3339=seconds`
    sudo sed -i.bak "s|2015 Digital Manufacturing Commons|2015 Digital Manufacturing Commons version: $timestamp  |" footer-tpl.html

    #
    # remove old code from apache
     mkdir -p /tmp/oldwww
     cd /tmp/oldwww
     sudo mv -p /var/www/html/* /tmp/oldwww
     sudo rm -rf /var/www/html/*
    # #moving files to web forlder
     sudo mv /tmp/dist/* /var/www/html/
    # restart apache
    sudo systemctl restart httpd
    exit

+
}

scpSend
echo "done updating -- back on local and done :)"
