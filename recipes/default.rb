#
# Cookbook Name:: cookbook_hub
# Recipe:: default
#

include_recipe 'apt'
include_recipe 'appbox'
include_recipe 'java::default'
include_recipe 'cookbook_hub::hub'
include_recipe 'cookbook_hub::service'
include_recipe 'cookbook_hub::nginx'