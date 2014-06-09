#!/bin/bash

sudo apt-get update

sudo apt-get install postgresql-9.1 libpq-dev nodejs openssl build-essential curl nginx -y
sudo apt-get --purge remove ruby-rvm
sudo rm -rf /usr/share/ruby-rvm /etc/rvmrc /etc/profile.d/rvm.sh

sudo apt-get install ruby 1.9.3 -y
pushd /etc/alternatives
sudo ln -sf /usr/bin/ruby1.9.3 ruby

ruby --version

sudo gem install rails  --no-ri --no-rdoc
sudo gem install bundler  --no-ri --no-rdoc

popd

sudo -u postgres psql -c "ALTER USER postgres PASSWORD 'postgres';"

export PGPASSWORD=postgres
createuser --superuser -U postgres -h localhost dev

sudo -u postgres psql -c "ALTER USER dev PASSWORD 'password1';"

cp /vagrant/nginx/default /etc/nginx/sites-available/default
service nginx restart

mkdir /etc/keychain