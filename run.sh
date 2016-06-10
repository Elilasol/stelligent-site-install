#!/bin/bash

# wget/install chefDK
wget https://packages.chef.io/stable/ubuntu/12.04/chefdk_0.14.25-1_amd64.deb
dpkg -i chefdk_0.14.25-1_amd64.deb

# move cookbook to /var/chef/cookbooks
mkdir -r /var/chef/cookbooks
mv stelligent-site-install /var/chef/cookbooks

# berks install/ohai,nginx fixes
# Normally I wouldn't be doing things this way, but I don't have time to 
# download and correct the issues with the nginx/ohai community cookbooks.
# This is a quick fix, and not a long term solution.
cd /var/chef/cookbooks
berks install
mv ~/.berkshelf/cookbooks/nginx* ~/.berkshelf/cookbooks/nginx
mv ~/.berkshelf/cookbooks/ohai* ~/.berkshelf/cookbooks/ohai

# run chef
chef-solo -c /var/chef/cookbooks/stelligent-site-install/solo.rb -j /var/chef/cookbooks/stelligent-site-install/web.json

# curl localhost:8000 for test
curl localhost:8000
