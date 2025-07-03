#!/bin/sh

FILE_FULLNAME=$(echo \"$0\" | xargs readlink -f)
FILE_FULLDIR=$(dirname "$FILE_FULLNAME")
sudo /bin/sh "$FILE_FULLDIR/Install/keylok_install"
