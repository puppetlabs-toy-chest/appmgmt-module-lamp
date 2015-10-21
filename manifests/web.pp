define lamp::web(
  $port = '80',
  $docroot = '/var/www/html',
  ){
  class { 'apache':
    default_mods => false,
    default_vhost => false,
  }

  apache::vhost { $name:
    port    => $port,
    docroot => $docroot,
  }

}
Lamp::Web produces Http {
  ip       => $::ipaddress,
  port     => $port,
  host     => $::fqdn
}
