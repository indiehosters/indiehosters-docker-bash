#!/bin/bash

echo Starting server...
sh /run.sh &
sleep 10

echo Generic lamp-git initialization...
sh /init/generic.sh

VERSION="7.0.2"

echo "Extracting ownCloud ${VERSION}..."
cd /data
tar xjf /init/owncloud-$VERSION.tar.bz2
rm -rf www-content
mv owncloud www-content

echo "Setting default config..."
cp /init/config.php ./www-content
chown -R root:www-data /data/www-content
chmod -R g+w /data/www-content

echo "Creating empty database..."
echo "CREATE DATABASE IF NOT EXISTS owncloud" | mysql

PWD=`pwgen 40 1`
echo "user: " > /data/login.txt
echo "pass: $PWD" >> /data/login.txt
echo "Please use your browser to set up a user, and edit /data/login.txt manually:"
cat /data/login.txt
