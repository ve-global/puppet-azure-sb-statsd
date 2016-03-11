# == Class: azure_sb_statsd::config
class azure_sb_statsd::config (
  $servers                           = $azure_sb_statsd::servers,
  $statsd                            = $azure_sb_statsd::statsd,
  $configdir                         = $azure_sb_statsd::configdir,
  $config                            = $azure_sb_statsd::config,

  $environment = $azure_sb_statsd::environment,
  $nodejs_bin  = $azure_sb_statsd::nodejs_bin,
  $azurejs     = "${azure_sb_statsd::node_module_dir}/azure-sb-statsd/azure-sb.js",
  $logfile     = $azure_sb_statsd::logfile,
) {

  file { $configdir:
    ensure => directory,
    mode   => '0755',
    owner  => 'root',
    group  => 'root',
  }->
  file { "${configdir}/azure-sb.json":
    content => template('azure_sb_statsd/azure-sb.json.erb'),
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
  }->
  file { "${configdir}/statsd.json":
    content => template('azure_sb_statsd/statsd.json.erb'),
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
  }

  file { $azure_sb_statsd::init_location:
    source => $azure_sb_statsd::init_script,
    mode   => $azure_sb_statsd::init_mode,
    owner  => 'root',
    group  => 'root',
  }

  file {  '/etc/default/azure-sb-statsd':
    content => template('azure_sb_statsd/azure-sb-defaults.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
  }

  file { '/var/log/azure-sb-statsd':
    ensure => directory,
    mode   => '0755',
    owner  => 'nobody',
    group  => 'root',
  }

  file { '/usr/local/sbin/azure-sb-statsd':
    source => 'puppet:///modules/azure_sb_statsd/azure-sb-wrapper',
    mode   => '0755',
    owner  => 'root',
    group  => 'root',
  }

}
