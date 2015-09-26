#
# Cookbook Name:: cookbook_hub
# Recipe:: hub
#

# Decipher the locations
archive_directory = Chef::Config[:file_cache_path]
hub_version = node['cookbook_hub']['hub']['version']
install_root_dir = node['cookbook_hub']['hub']['install_root_dir']
data_directory = node['cookbook_hub']['hub']['data_dir']
backup_directory = node['cookbook_hub']['hub']['backup_dir']
download_url = node['cookbook_hub']['hub']['download_url']

# Calculate some variables
hub_archive_name = "Hub-#{hub_version}.zip"
hub_archive_path = "#{archive_directory}/#{hub_archive_name}"
install_dir = "#{install_root_dir}/#{hub_version}"
current_dir = "#{install_root_dir}/current"

# Install the unzip package
package "unzip" do
  action :install
end

# Create the hub root directory
directory install_root_dir do
  recursive true
  action :create
end

# Create the hub version directory
directory install_dir do
  recursive true
  action :create
end

# Set the symbolic link to the current installation
link current_dir do
  to install_dir
end

# Create the data directory
directory data_directory do
  recursive true
  action :create
end

# Create the backup directory
directory backup_directory do
  recursive true
  action :create
end

# Download the version of hub, if we don't already have it
remote_file hub_archive_path do
  backup false
  source download_url
  action :create_if_missing
  notifies :run, "bash[extract-hub]", :immediately
end

# Run the commands to extract and move hub into place.
bash "extract-hub" do
  code <<-EOH
    unzip #{hub_archive_path} -d #{install_dir}
  EOH
  action :nothing
end