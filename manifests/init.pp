application lamp (
  $db_user,
  $db_password,
  $docroot = '/var/www/html',
) {

  lamp::web { $name:
    docroot => $docroot,
    export  => Http["lamp-${name}"],
  }

  lamp::app { $name:
    docroot => $docroot,
    consume => Sql["lamp-${name}"],
  }

  lamp::db { $name:
    db_user     => $db_user,
    db_password => $db_password,
    export      => Sql["lamp-${name}"],
  }

}
