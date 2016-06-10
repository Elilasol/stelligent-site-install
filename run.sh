#!/bin/bash

# wget/install chefDK
wget https://packages.chef.io/stable/ubuntu/12.04/chefdk_0.14.25-1_amd64.deb
sudo dpkg -i chefdk_0.14.25-1_amd64.deb

# move cookbook to /var/chef/cookbooks
sudo mkdir /var/chef
sudo mkdir /var/chef/cookbooks
sudo cp -r stelligent-site-install-cookbook /var/chef/cookbooks

# berks install/ohai,nginx fixes
cd /var/chef/cookbooks/stelligent-site-install-cookbook
sudo berks vendor

# run chef
sudo chef-solo -c /var/chef/cookbooks/stelligent-site-install-cookbook/solo.rb -j /var/chef/cookbooks/stelligent-site-install-cookbook/web.json

# curl localhost:8000 for test
curl localhost:8000
