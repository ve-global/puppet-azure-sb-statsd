# puppet-azure_sb_statsd

[![Build Status](https://travis-ci.org/andyroyle/puppet-azure-sb-statsd.png)](https://travis-ci.org/andyroyle/puppet-azure-sb-statsd) [![Puppet Forge](http://img.shields.io/puppetforge/v/andyroyle/azure_sb_statsd.svg?style=flat)](https://forge.puppetlabs.com/andyroyle/azure_sb_statsd)

## Description

This Puppet module will install [azure-sb-statsd](https://github.com/andyroyle/puppet-azure-sb-statsd/) on Debian or RedHat.

## Installation

`puppet module install --modulepath /path/to/puppet/modules andyroyle-azure_sb_statsd`

## Requirements

This module assumes nodejs & npm is installed on the host, but will not do it for you. I recommend using [puppet/nodejs](https://github.com/puppet-community/puppet-nodejs) to set this up.

## Usage
```puppet
    class { 'azure_sb_statsd':
      servers => [
        {
          endpoint => 'http://my.servicebus.instance.com',
          key      => 'accesskey',
          keyname  => 'RootManageSharedAccessKey',
          queues   => true,
          topics   => true,
          tags     => {                     # tags are only supported by influxdb backend
            foo => 'bar'
          },
          prefix   => 'bar.azure-sb.yay' # prefix to apply to the metric name
        }
      ],
      statsd => {
        host     => 'localhost',
        port     => 8125,
        interval => 10, # interval in seconds to send metrics,
        prefix   => 'foo', # global prefix to apply to all metrics,
        debug    => true # print out metrics that are logged (default false)
      }
    }
```

## Testing

```
bundle install
bundle exec librarian-puppet install
vagrant up
```

## Custom Nodejs Environment

Use the `$environment` parameter to add custom environment variables or run scripts in the `/etc/default/azure-sb-statsd` file:

```
class { 'azure-sb-statsd':
  # ...
  environment  => [
    'PATH=/opt/my/path:$PATH',
  ]
}
```

## This looks familiar
Module structure largely copy-pasted from [puppet-statsd](https://github.com/justindowning/puppet-statsd)
