#
# Cookbook Name:: cookbook_hub
# Recipe:: service
#

# Decipher the locations
archive_directory = Chef::Config[:file_cache_path]
hub_version = node['cookbook_hub']['hub']['version']
install_root_dir = node['cookbook_hub']['hub']['install_root_dir']
data_directory = node['cookbook_hub']['hub']['data_dir']
backup_directory = node['cookbook_hub']['hub']['backup_dir']
memory_options = node['cookbook_hub']['hub']['memory_options']

# Calculate some variables
hub_archive_name = "Hub-#{hub_version}.zip"
hub_archive_path = "#{archive_directory}/#{hub_archive_name}"
install_dir = "#{install_root_dir}/#{hub_version}"
current_dir = "#{install_root_dir}/current"
shell_script_path = "#{install_dir}/bin/hub.sh"

# Create Hub Service
template '/etc/init/hub.conf' do
  source 'hub.conf.erb'
  variables(
    :memory_options => memory_options,
    :shell_script_path => shell_script_path
  )
  notifies :start, 'service[hub]', :immediately
end

# Start Hub Service
service "hub" do
  provider Chef::Provider::Service::Upstart
  action :restart
end