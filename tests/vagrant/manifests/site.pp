case $operatingsystem {
  /^(Debian|Ubuntu)$/: { include apt }
  'RedHat', 'CentOS':  { include epel }
  default: { notify { 'unsupported os!': }}
}

class { 'nodejs': manage_package_repo => true, repo_url_suffix => '5.x', }->
class { 'azure_sb_statsd':
  servers => [
    {
      endpoint => 'sb://localhost/',
      key      => 'accesskey',
      keyname  => 'RootManageSharedAccessKey',
      queues   => true,
      topics   => true,
      prefix   => 'bar.servicebus.yay',
      tags     => {
        foo => 'bar'
      }
    }
  ],
  statsd  => {
    host     => 'localhost',
    port     => 8125,
    interval => 10,
    prefix   => 'foo'
  }
}
