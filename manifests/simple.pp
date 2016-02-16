application lamp::simple (
  $db_user,
  $db_password,
  $docroot = '/var/www/html',
) {

  site::apache { $name:
    docroot => $docroot,
    export  => Http["lamp-${name}"],
  }

  lamp::app { $name:
    docroot => $docroot,
    consume => Sql["lamp-${name}"],
  }

  site::mysql { $name:
    db_user     => $db_user,
    db_password => $db_password,
    export      => Sql["lamp-${name}"],
  }

}
