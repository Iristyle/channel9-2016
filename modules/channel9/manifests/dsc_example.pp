class channel9::dsc_example {

  $test_file_contents = 'bar'

  dsc_file { 'tmp_file':
    dsc_ensure => 'present',
    dsc_type            => 'File',
    dsc_destinationpath => 'c:/windows/temp/foo.txt',
    dsc_contents        => $test_file_contents,

    # DSC specific properties
    dsc_force           => true,
    dsc_attributes      => ['Archive'],
  }

  dsc_registry { 'registry_test':
    dsc_ensure    => 'Present',
    dsc_key       => 'HKEY_LOCAL_MACHINE\\SOFTWARE\\TestKey',

    dsc_valuename => 'TestBinaryValue',
    dsc_valuedata => 'BEEF',
    dsc_valuetype => 'Binary',
  }
}
