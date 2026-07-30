#!/bin/bash

echo "Setting up temporary rootless user for container development"
echo "The following errors we don't care about, it just means the Dockerfile CMD keyword doesn't get ran"
echo "----------"

source .env
# set source environment variables

# make an entry to containers /etc/passwd userid -> username mapping
# allocate a container specific name but make it in the same group and same user id

usermod -l $USERNAME $IMAGE_USERNAME
groupmod -n $USERNAME $IMAGE_USERNAME

exec su - "$USERNAME" -c "exec \"$@\""
# exec means run the following command in a new shell replacing this current one
# su means switch user
# -c means to run the following command in that new terminal
# exec means to again make a new terminal and run the parameter 

#### THE ABOVE THROWS A WARNING Because I am trying to switch a user and open a new shell whilst passing a commadn into teh new shell whihc it doesn't like
