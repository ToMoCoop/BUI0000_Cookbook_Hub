name             'cookbook_hub'
maintainer       'Fred Thompson'
maintainer_email 'fred.thompson@buildempire.co.uk'
license          'Apache 2.0'
description      'The JetBrains Hub site.'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

recipe 'cookbook_hub', 'The JetBrains Hub site.'

%w{ ubuntu }.each do |os|
  supports os
end

%w{appbox apt build-essential chef_nginx java rng-tools zipfile}.each do |cb|
  depends cb
end
