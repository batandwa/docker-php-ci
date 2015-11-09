#!/bin/bash

apt-get update
apt-get install --yes curl
chmod -Rf 0777 /var/app/PHPCI/build
curl --silent --location https://deb.nodesource.com/setup_4.x | sudo bash -
apt-get install --yes nodejs
apt-get install --yes build-essential
npm install -g grunt-cli
apt-get install --yes ruby
gem install sass

touch /var/.build-tool-set-up