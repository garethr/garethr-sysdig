Puppet module for installing
[Sysdig](http://www.sysdig.org/) from the [official
repository](http://www.sysdig.org/wiki/how-to-install-sysdig-for-linux/#manual-installation)
on Ubuntu or RedHat.

This module is also available on the [Puppet
Forge](https://forge.puppetlabs.com/garethr/sysdig)

[![Build
Status](https://secure.travis-ci.org/garethr/garethr-sysdig.png)](http://travis-ci.org/garethr/garethr-sysdig)

## Usage

The module includes a single class:

```puppet
include 'sysdig'
```

This will install sysdig as well as the apt or yum repository. On Ubuntu
this will also install the required linux kernel headers.

The class currently has only one parameter, to affect the ensure value
of the package. For instance if you want to remove sysdig you can use:

```puppet
class { 'sysdig':
  ensure => absent,
}
```
