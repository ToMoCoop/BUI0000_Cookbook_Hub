#
# Cookbook Name:: cookbook_hub
# Recipe:: hub
#

# Decipher the locations
archive_directory = Chef::Config[:file_cache_path]
cookbook_hub = node['cookbook_hub']
hub_version = cookbook_hub['version']
install_root_dir = cookbook_hub['install_root_dir']
data_directory = cookbook_hub['data_dir']
backup_directory = cookbook_hub['backup_dir']
download_url = cookbook_hub['download_url']
shell_script_path = cookbook_hub['shell_script_path']

url = cookbook_hub['url']
upstream_port = cookbook_hub['upstream_port']

# Calculate some variables
hub_archive_name = "hub-#{hub_version}.zip"
hub_archive_path = "#{archive_directory}/#{hub_archive_name}"
releases_dir = "#{install_root_dir}/releases"
install_dir = "#{releases_dir}/hub-#{hub_version}"
current_dir = "#{install_root_dir}/current"

# Install the unzip package
package 'unzip' do
  action :install
end

# Create the hub root directory
directory install_root_dir do
  recursive true
  action :create
end

# Create the hub releases directory
directory releases_dir do
  recursive true
  action :create
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
end

# Only unzip if the directory doesn't
unless Dir.exist? install_dir

  # Extract into place.
  zipfile hub_archive_path do
    into releases_dir
  end

end

# Set the symbolic link to the current installation
link current_dir do
  to install_dir
end

systemd_unit 'hub.service' do
  action [:stop]
end

# Run the commands to configure hub to run behind a nginx proxy
execute 'configure to run behind a proxy' do
  command "#{shell_script_path} configure --listen-port #{upstream_port} --base-url #{url} --data-dir #{data_directory} --backups-dir #{backup_directory}"
end
