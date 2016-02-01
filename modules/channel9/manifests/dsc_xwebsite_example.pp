class channel9::dsc_xwebsite_example {

  dsc_file {'c:\\inetpub':
    dsc_ensure => 'present',
    dsc_type => 'directory',
    dsc_destinationpath => 'c:\\inetpub',
  }
  ->
  dsc_windowsfeature {'iis':
    dsc_ensure => 'present',
    dsc_name   => 'web-server',
  }
  ->
  dsc_windowsfeature {'iis-tools':
    dsc_ensure => 'present',
    dsc_name   => 'web-mgmt-tools',
  }
  ->
  dsc_file {'c:\\inetpub\\testsite':
    dsc_ensure => 'present',
    dsc_type => 'directory',
    dsc_destinationpath => 'c:\\inetpub\\testsite',
  }
  ->
  dsc_xwebsite{'NewWebsite':
    dsc_ensure       => 'Present',
    dsc_state        => 'Started',
    dsc_name         => 'TestSite',
    dsc_physicalpath => 'C:\\inetpub\\testsite',
    dsc_bindinginfo  => {
      'Protocol' => 'HTTP',
      'Port'     => 8089
    }
  }
  ->
  dsc_file { 'html_hello':
    dsc_ensure => 'present',
    dsc_type            => 'File',
    dsc_destinationpath => 'c:\\inetpub\\testsite\\index.html',
    dsc_contents        => '<html><body>Hello from Puppet + DSC!</body></html>',
  }
}
