# == Class azure_sb_statsd
class azure_sb_statsd (
  $ensure           = $azure_sb_statsd::params::ensure,
  $node_module_dir  = $azure_sb_statsd::params::node_module_dir,
  $nodejs_bin       = $azure_sb_statsd::params::nodejs_bin,
  $environment      = $azure_sb_statsd::params::environment,

  $servers          = $azure_sb_statsd::params::servers,
  $statsd           = $azure_sb_statsd::params::statsd,
  $configdir        = $azure_sb_statsd::params::configdir,
  $logfile          = $azure_sb_statsd::params::logfile,

  $manage_service   = $azure_sb_statsd::params::manage_service,
  $service_ensure   = $azure_sb_statsd::params::service_ensure,
  $service_enable   = $azure_sb_statsd::params::service_enable,

  $config           = $azure_sb_statsd::params::config,

  $init_location    = $azure_sb_statsd::params::init_location,
  $init_mode        = $azure_sb_statsd::params::init_mode,
  $init_provider    = $azure_sb_statsd::params::init_provider,
  $init_script      = $azure_sb_statsd::params::init_script,

  $package_name     = $azure_sb_statsd::params::package_name,
  $package_source   = $azure_sb_statsd::params::package_source,
  $package_provider = $azure_sb_statsd::params::package_provider,

  $dependencies     = $azure_sb_statsd::params::dependencies,
) inherits azure_sb_statsd::params {

  if $dependencies {
    $dependencies -> Class['azure_sb_statsd']
  }

  class { 'azure_sb_statsd::config': }

  package { 'azure_sb_statsd':
    ensure   => $ensure,
    name     => $package_name,
    provider => $package_provider,
    source   => $package_source
  }

  if $manage_service == true {
    service { 'azure-sb-statsd':
      ensure    => $service_ensure,
      enable    => $service_enable,
      hasstatus => true,
      provider  => $init_provider,
      subscribe => Class['azure_sb_statsd::config'],
      require   => [
        Package['azure_sb_statsd'],
        File['/var/log/azure-sb-statsd']
      ],
    }
  }
}
