DisplayUsage() {
cat << EOM
USAGE: 

Enter the EPPN of the user you want to make a superadmin.
./create_superuser.sh some_eppn

EOM
exit 1
}

#
# Minimum args
#
if [ $# -lt 1 ]
then
  DisplayUsage
fi

eppn="$1"

user=$(psql -U postgres -d gforge -c "select user_id from users where user_name = '$eppn'")

# Make sure the user exists
if [[ $user != *"(0 rows)"* ]]
then

	# If so, check if they already have a row in the role assignment table.  If not, insert into the role assignment table, else do nothing
	userRole=$(psql -U postgres -d gforge -c "select role_id from user_role_assignment where user_id = (select user_id from users where user_name = '$eppn') and role_id = 1")
	echo $userRole
	if [[ $userRole == *"(0 rows)"* ]]
	then
		user=$(psql -U postgres -d gforge -c "insert into user_role_assignment (user_id, role_id) values ((select user_id from users where user_name = '$eppn'), 1)")
		
		# Check on the insert statement, output errors if it appears to be an error
		if [[ $user == "INSERT 0 1" ]]
		then
			echo "User with EPPN $eppn is now a super admin"
		else
			echo "Something went wrong..."
			echo $user
		fi
	else
		echo "User with EPPN $eppn is already a super admin"
	fi

else
	echo "Did not find user with EPPN $eppn, cannot create superuser"
fi
