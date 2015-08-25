# == Class: sysdig
#
# Install sysdig, the system-level exploration tool
#
# === Parameters
#
# [*ensure*]
#   What version of sysdig is required, defaults to latest
#
# [*manage_epel*]
#   manage the epel repository
#   Default: true
#
class sysdig (
  $ensure = $sysdig::params::ensure,
  $manage_epel=true,
) inherits sysdig::params {

  validate_string($ensure)

  class { 'sysdig::install':
    manage_epel => $manage_epel,
  } ->
  Class['sysdig']
}
