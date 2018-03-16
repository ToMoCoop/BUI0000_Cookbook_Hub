#
# Cookbook Name:: cookbook_hub
# Recipe:: service
#

# Decipher the locations
cookbook_hub = node['cookbook_hub']
shell_script_path = cookbook_hub['shell_script_path']


systemd_unit 'hub.service' do
  enabled true
  active true
  content(
    Unit: {
      Description: 'JetBrains Hub',
      Requires: 'network.target',
      After: 'syslog.target network.target',
    },
    Service: {
      Type: 'forking',
      ExecStart: "#{shell_script_path} start",
      ExecStop: "#{shell_script_path} stop",
      User: 'root',
    },
    Install: {
      WantedBy: 'multi-user.target',
    }
  )
  action [:create, :enable, :start]
end