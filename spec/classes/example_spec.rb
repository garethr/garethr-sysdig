require 'spec_helper'

describe 'sysdig' do
  ['Debian', 'RedHat'].each do |osfamily|
    if osfamily == 'Debian'
      let(:facts) { {
        :osfamily               => osfamily,
        :operatingsystem        => 'Ubuntu',
        :lsbdistid              => 'Ubuntu',
        :lsbdistcodename        => 'maverick',
        :kernelrelease          => '3.8.0-29-generic',
        :operatingsystemrelease => '10.04',
      } }

    end

    if osfamily == 'RedHat'
      let(:facts) {{
        :osfamily => osfamily,
      }}

      context 'on Redhat' do
        describe 'should install required repo' do
          it { should contain_yumrepo('sysdig') }
        end
      end
    end

    describe "without any parameters on #{osfamily}" do
      it { should compile.with_all_deps }

      it { should contain_class('sysdig::params') }
      it { should contain_class('sysdig::install') }

      it { should contain_package('sysdig').with_ensure('installed') }
    end

    describe "with ensure set to absent on #{osfamily}" do
      let(:params) { {'ensure' => 'absent' } }
      it { should contain_package('sysdig').with_ensure('absent') }
    end

  end

  describe 'On Debian based systems' do
    let(:facts) { {
      :osfamily               => 'Debian',
      :operatingsystem        => 'Ubuntu',
      :lsbdistid              => 'Ubuntu',
      :lsbdistcodename        => 'maverick',
      :kernelrelease          => '3.8.0-29-generic',
      :operatingsystemrelease => '10.04',
    } }
    it { should contain_package('linux-headers-3.8.0-29-generic') }
    it { should contain_class('apt') }
  end

end
