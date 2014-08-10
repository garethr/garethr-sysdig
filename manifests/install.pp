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
        key               => 'EC51E8C4',
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

      yumrepo { 'sysdig':
        baseurl  => 'http://download.draios.com/stable/rpm/$basearch',
        descr    => 'Sysdig repository by Draios',
        enabled  => 1,
        gpgcheck => 0,
      }

      $dependencies = Yumrepo['sysdig']
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
