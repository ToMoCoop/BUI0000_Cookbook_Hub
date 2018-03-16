default['cookbook_hub']['hostname'] = 'localhost'
default['cookbook_hub']['listen_port'] = 443
default['cookbook_hub']['upstream_host'] = 'localhost'
default['cookbook_hub']['upstream_port'] = 20001
default['cookbook_hub']['version'] = '2018.1.8871'

default['cookbook_hub']['ssl']['key'] = nil
default['cookbook_hub']['ssl']['cert'] = nil

default['cookbook_hub']['url'] = "https://#{node['cookbook_hub']['hostname']}:#{node['cookbook_hub']['listen_port']}"
default['cookbook_hub']['upstream_url'] = "http://#{node['cookbook_hub']['upstream_host']}:#{node['cookbook_hub']['upstream_port']}"
default['cookbook_hub']['install_root_dir'] = '/opt/hub'
default['cookbook_hub']['shell_script_path'] = "#{node['cookbook_hub']['install_root_dir']}/current/bin/hub.sh"
default['cookbook_hub']['data_dir'] = '/root/.HubData'
default['cookbook_hub']['backup_dir'] = '/root/.HubBackup'
default['cookbook_hub']['download_url'] = "https://download.jetbrains.com/hub/hub-#{node['cookbook_hub']['version']}.zip"
#default['cookbook_hub']['memory_options'] = '-Xmx1g'

default['java']['jdk_version'] = '8'
