require 'erb'
require 'dsc_utils'
test_name 'MODULES-2230 - C68708 - Attempt to Apply DSC Registry Resource with Invalid "Key" Specified'

confine(:to, :platform => 'windows')

# Init
local_files_root_path = ENV['MANIFESTS'] || 'tests/manifests'

# ERB Manifest
dsc_type = 'registry'
dsc_props = {
  :dsc_ensure    => 'Present',
  :dsc_key       => 'HKEY_COW_MEAT\TestKey',
  :dsc_valuename => 'TestValueName',
  :dsc_valuetype => 'String'
}

dsc_manifest_template_path = File.join(local_files_root_path, 'basic_dsc_resources', 'dsc_single_resource.pp.erb')
dsc_manifest = ERB.new(File.read(dsc_manifest_template_path), 0, '>').result(binding)

# Verify
error_msg = /registry hive was specified in registry key 'HKEY_COW_MEAT\\TestKey'/

# Tests
agents.each do |agent|
  step 'Attempt to Apply Manifest'
  on(agent, puppet('apply'), :stdin => dsc_manifest, :acceptable_exit_codes => [0,2]) do |result|
    assert_match(error_msg, result.stderr, 'Expected error was not detected!')
  end
end
