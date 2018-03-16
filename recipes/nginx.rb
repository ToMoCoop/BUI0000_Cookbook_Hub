#
# Cookbook Name:: cookbook_hub
# Recipe:: nginx
#

node.override['nginx']['version'] = '1.12.1'
node.override['nginx']['source']['checksum'] = '8793bf426485a30f91021b6b945a9fd8a84d87d17b566562c3797aba8fac76fb'
node.override['nginx']['source']['version']  = node['nginx']['version']
node.override['nginx']['source']['url']      = "http://nginx.org/download/nginx-#{node['nginx']['source']['version']}.tar.gz"

include_recipe 'chef_nginx::source'

# Retrieve some variables and make them available locally with easier names.
appname = 'hub'
cookbook_hub = node['cookbook_hub']
hostname = cookbook_hub['hostname']
listen_port = cookbook_hub['listen_port']
upstream_url = cookbook_hub['upstream_url']
ssl_key = cookbook_hub['ssl']['key']
ssl_cert = cookbook_hub['ssl']['cert']
nginx_dir = node['nginx']['dir']
nginx_log_dir = node['nginx']['log_dir']


# Calculate some variables based on what we know.
nginx_vhost_location = File.join(nginx_dir, 'sites-available', appname)


# Write the nginx vhost file
template nginx_vhost_location do
  source    'nginx_vhost.conf.erb'
  cookbook  'cookbook_hub'
  mode      '0644'
  owner     'root'
  group     'root'
  variables(
    :appname        => appname,
    :log_dir        => nginx_log_dir,
    :hostname       => hostname,
    :listen_port    => listen_port,
    :upstream_url  =>  upstream_url,
    :ssl_key        => ssl_key,
    :ssl_cert       => ssl_cert,
  )
  notifies :reload, 'service[nginx]'
end

# Restart nginx
nginx_site appname do
  notifies :reload, 'service[nginx]'
end