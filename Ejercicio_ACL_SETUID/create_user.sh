#!/bin/bash
user=ej1
pass=$(openssl passwd -6 123)
group=users
home=/home/$user
shell=/bin/bash
echo "Creating user $user"
useradd $user -g $group -d $home -m -s $shell -p $pass
if test $? -eq 0
then
	echo "User $user (password:123) created successfully"
	exit 0
else
	echo "User $user was not created"
	exit 1
fi