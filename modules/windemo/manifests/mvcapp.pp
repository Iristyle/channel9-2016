# == Class: mvcapp
#
# This class installs the razorC MVC application
#
class windemo::mvcapp {

  $app_zip = 'razorC_v1.1.1.zip'
  $app_zip_path = "C:\\Windows\\Temp\\${app_zip}"
  $app_pool = 'mvc'
  $app_location = 'C:\inetpub\wwwroot\razorC'

  file { "${app_zip_path}":
    ensure => file,
    source => "puppet:///modules/windemo/${app_zip}",
    source_permissions => ignore,
  } ~>

  exec { 'extract_zip':
    path        => [$::path, 'C:\\Program Files\\7-Zip'],
    command     => "7z.exe x ${app_zip_path} -oC:\\inetpub\\wwwroot",
    creates     => "${app_location}\\Web.config",
  } ~>

  iis::manage_app_pool {"$app_pool":
    ensure                  => present,
    enable_32_bit           => true,
    managed_runtime_version => 'v4.0',
    managed_pipeline_mode   => 'Integrated',
  } ~>

  # NOTE: IIS is very touchy around extra slashes

  iis::manage_site {'razorC':
    ensure        => present,
    site_path     => "${app_location}",
    port          => '80',
    ip_address    => '*',
    app_pool      => "${app_pool}",
  }


  acl { "${app_location}":
    purge                       => true,
    inherit_parent_permissions  => false,
    permissions =>
    [
      { identity => 'Administrators', rights => ['full'] },
      { identity => 'IIS_IUSRS', rights => ['read'] },
      { identity => 'IUSR', rights => ['read'] },
      { identity => "IIS APPPOOL\\${app_pool}", rights => ['read'] },
    ],
    require => Iis::Manage_app_pool["$app_pool"],
  }


  # $customErrors = 'Off'

  # file { 'Web.Config' :
  #   ensure  => present,
  #   path    => "${$app_location}\\Web.Config",
  #   content => template('windemo/Web.Config.erb'),
  #   require => Exec['extract_zip'],
  # }



  # SDF file can't be written to
  # acl { "${app_location}/App_Data":
  #   permissions =>
  #   [
  #     { identity => "IIS APPPOOL\\${app_pool}", rights => ['full'] },
  #     { identity => 'IIS_IUSRS', rights => ['full'] },
  #   ],
  #   require => Iis::Manage_app_pool["$app_pool"],
  # }

  # acl { "${app_location}/upfiles":
  #   permissions =>
  #   [
  #     { identity => "IIS APPPOOL\\${app_pool}", rights => ['full'] },
  #     { identity => 'IIS_IUSRS', rights => ['full'] },
  #   ],
  #   require => Iis::Manage_app_pool["$app_pool"],
  # }

  # acl { "${app_location}/rcLayouts":
  #   permissions =>
  #   [
  #     { identity => "IIS APPPOOL\\${app_pool}", rights => ['full'] },
  #     { identity => 'IIS_IUSRS', rights => ['full'] },
  #   ],
  #   require => Iis::Manage_app_pool["$app_pool"],
  # }
}
