#!/bin/bash

sudo apt-get update

sudo apt-get install libsqlite3-dev nodejs openssl build-essential curl -y
sudo apt-get --purge remove ruby-rvm
sudo rm -rf /usr/share/ruby-rvm /etc/rvmrc /etc/profile.d/rvm.sh

sudo apt-get install ruby 1.9.3 -y
pushd /etc/alternatives
sudo ln -sf /usr/bin/ruby1.9.3 ruby

ruby --version

sudo gem install rails  --no-ri --no-rdoc
sudo gem install bundler  --no-ri --no-rdoc

popd