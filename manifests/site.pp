## site.pp ##

# Define filebucket 'main':
filebucket { 'main':
  server => 'master',
  path   => false,
}

# Make filebucket 'main' the default backup location for all File resources:
File { backup => 'main' }

node default {
}

case downcase($::osfamily) {
  'windows': {
      # include channel9::dsc_example
      # include channel9::dsc_xwebsite_example
  }
}

# these are our custom facts
if ($::dsc_enabled == 'true') {
   notice('node has been identified as DSC enabled')
}

