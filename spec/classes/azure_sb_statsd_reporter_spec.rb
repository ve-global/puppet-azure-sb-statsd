require 'spec_helper'

describe 'azure_sb_statsd', :type => :class do

  ['Debian', 'RedHat'].each do |osfamily|
    context "using #{osfamily}" do
      let(:facts) { {
        :osfamily => osfamily
      } }

      it { should contain_class('azure_sb_statsd') }
      it { should contain_class('azure_sb_statsd::params') }
      it { should contain_azure_sb_statsd__config }
      it { should contain_package('azure_sb_statsd').with_ensure('present') }
      it { should contain_service('azure-sb-statsd').with_ensure('running') }
      it { should contain_service('azure-sb-statsd').with_enable(true) }

      it { should contain_file('/etc/azure-sb-statsd') }
      it { should contain_file('/etc/azure-sb-statsd/azure-sb.json') }
      it { should contain_file('/etc/azure-sb-statsd/statsd.json') }
      it { should contain_file('/etc/default/azure-sb-statsd') }
      it { should contain_file('/var/log/azure-sb-statsd') }
      it { should contain_file('/usr/local/sbin/azure-sb-statsd') }

      if osfamily == 'Debian'
        it { should contain_file('/etc/init/azure-sb-statsd.conf') }
      end

      if osfamily == 'RedHat'
        it { should contain_file('/etc/init.d/azure-sb-statsd') }
      end

      describe 'stopping the statsd service' do
	let(:params) {{
	  :service_ensure => 'stopped',
        }}
        it { should contain_service('azure-sb-statsd').with_ensure('stopped') }
      end

      describe 'disabling the statsd service' do
	let(:params) {{
	  :service_enable => false,
        }}
        it { should contain_service('azure-sb-statsd').with_enable(false) }
      end

      describe 'disabling the management of the statsd service' do
	let(:params) {{
	  :manage_service => false,
        }}
        it { should_not contain_service('azure-sb-statsd') }
      end
     end
  end

end
