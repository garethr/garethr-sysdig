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
  $ensure = $sysdig::params::ensure,
) inherits sysdig::params {

  validate_string($ensure)

  class { 'sysdig::install': } ->
  Class['sysdig']
}
