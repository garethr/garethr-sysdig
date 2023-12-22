# == Class sysdig::install
#
class sysdig::install {
  case $facts['os']['family'] {
    'Debian' : {
      include apt

      apt::source { 'sysdig':
        location => 'https://download.sysdig.com/stable/deb',
        release  => 'stable-$(ARCH)/',
        repos    => '',
        key      => {
          'id'     => 'D27A72F32D867DF9300A241574490FD6EC51E8C4',
          'source' => 'https://download.sysdig.com/DRAIOS-GPG-KEY.public',
        }
        ,
        include  => {
          'src'    => false,
        }
        ,
      }

      ensure_packages(["linux-headers-${facts['kernelrelease']}"])

      $dependencies = [Apt::Source['sysdig'], Package["linux-headers-${facts['kernelrelease']}"],]
    }
    'RedHat' : {
      # include 'epel'
      yumrepo { 'sysdig':
        baseurl  => 'https://download.sysdig.com/stable/rpm/$basearch',
        descr    => 'Sysdig repository by Draios',
        enabled  => 1,
        gpgcheck => 0,
      }

      ensure_packages(["kernel-devel-${facts['kernelrelease']}"])

      # $dependencies = [ Yumrepo['sysdig'], Class['epel'] ]

      $dependencies = [Yumrepo['sysdig']]
    }
    default  : {
      $dependencies = []
    }
  }

  package { 'sysdig':
    ensure  => $sysdig::ensure,
    require => $dependencies,
  }
}
