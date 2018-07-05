#!/bin/bash
#set -x

cd "$(dirname "$0")"
source ./import.sh


HOST="localhost"

if [[ "$OSTYPE" == "darwin"* ]]; then
    HOST="host.docker.internal"
fi

# create the Movies oauth2 profile
import http://localhost:8080/tag ../resources/profile-oauth2-movies.json

# set the newly created oauth2 profile as the default profile
import http://localhost:8080/tag ../resources/default-oauth2-profile.json

# load 4 accounts with their respective set of roles
import http://localhost:8080/tag ../resources/account-alex.json
import http://localhost:8080/tag ../resources/account-john.json
import http://localhost:8080/tag ../resources/account-mark.json
import http://localhost:8080/tag ../resources/account-nick.json

# create an API connection
DOCKER_HOST=${HOST} import http://localhost:8080/tag ../resources/api-movies.json

# Create the LDAP Connection
DOCKER_HOST=${HOST} import http://localhost:8080/tag ../resources/ldap-movies.json

# Create the LDAP Account Source
DOCKER_HOST=${HOST} import http://localhost:8080/tag ../resources/movie-ldap-account-source.json
