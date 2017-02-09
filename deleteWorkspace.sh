#!/bin/bash
DisplayUsage() {
cat << EOM
USAGE:

Enter the id of the workspace you wish to delete.
./deleteWorkspace.sh some_id

EOM
exit 1
}1

#
# Minimum args
#
if [ $# -lt 1 ]
then
  DisplayUsage
fi

id="$1"

# user=$(psql -U postgres -d gforge -c "UPDATE groups SET use_webdav='0' WHERE group_id='$id';")

user=$(psql -U postgres -d gforge -c "UPDATE groups SET use_webdav='0' WHERE group_id='$id';")
echo $user

if [[ $user == *"(1 rows)"* ]]
then
  echo "Soft Deleted the workspace with id='$id'";
else
  echo "Something went wrong call the ghost busters"
fi
