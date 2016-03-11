# == Class: azure_sb_statsd::params
class azure_sb_statsd::params {
  $ensure           = 'present'
  $node_module_dir  = '/usr/lib/node_modules'
  $nodejs_bin       = '/usr/bin/node'
  $environment      = []

  $servers          = []
  $statsd           = { }
  $configdir        = '/etc/azure-sb-statsd'
  $logfile          = '/var/log/azure-sb-statsd/azure-sb-statsd.log'

  $manage_service   = true
  $service_ensure   = 'running'
  $service_enable   = true

  $config           = { }

  $dependencies     = undef

  $package_name     = 'azure-sb-statsd'
  $package_source   = undef
  $package_provider = 'npm'

  case $::osfamily {
    'RedHat', 'Amazon': {
      $init_location = '/etc/init.d/azure-sb-statsd'
      $init_mode     = '0755'
      $init_provider = 'redhat'
      $init_script   = 'puppet:///modules/azure_sb_statsd/azure-sb-init-rhel'
    }
    'Debian': {
      $init_location = '/etc/init/azure-sb-statsd.conf'
      $init_mode     = '0644'
      $init_provider = 'upstart'
      $init_script   = 'puppet:///modules/azure_sb_statsd/azure-sb-upstart'
    }
    default: {
      fail('Unsupported OS Family')
    }
  }
}
