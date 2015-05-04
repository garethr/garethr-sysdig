# == Class sysdig::install
#
class sysdig::install {

  case $::osfamily {
    'Debian': {

      include apt
      apt::source { 'sysdig':
        location          => 'http://download.draios.com/stable/deb',
        release           => 'stable-$(ARCH)/',
        repos             => '',
        required_packages => 'debian-keyring debian-archive-keyring',
        key               => 'D27A72F32D867DF9300A241574490FD6EC51E8C4',
        key_source        => 'https://s3.amazonaws.com/download.draios.com/DRAIOS-GPG-KEY.public',
        include_src       => false,
      }

      ensure_packages(["linux-headers-${::kernelrelease}"])

      $dependencies = [
        Apt::Source['sysdig'],
        Package["linux-headers-${::kernelrelease}"],
      ]
    }
    'RedHat': {
      include 'epel'
      yumrepo { 'sysdig':
        baseurl  => 'http://download.draios.com/stable/rpm/$basearch',
        descr    => 'Sysdig repository by Draios',
        enabled  => 1,
        gpgcheck => 0,
      }

      ensure_packages(["kernel-devel-${::kernelrelease}"])

      $dependencies = [ Yumrepo['sysdig'], Class['epel'] ]
    }
    default: {
      $dependencies = []
    }
  }

  package { 'sysdig':
    ensure  => $sysdig::ensure,
    require => $dependencies,
  }
}
