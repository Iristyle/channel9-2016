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
      # include windemo::dotnet_enable
      # include windemo::sqlce
      # include windemo::iis_enable
      # include windemo::mvcapp

      # alternative using DSC
      # include windemo::dsc_example
      # include windemo::dsc_xwebsite_example
  }
}

