# == Class: sysdig
#
# Install sysdig, the system-level exploration tool
#
# === Parameters
#
# [*ensure*]
#   What version of sysdig is required, defaults to latest
#
class sysdig (
  String $ensure = $sysdig::params::ensure,
) inherits sysdig::params {
  class { 'sysdig::install': }
}
