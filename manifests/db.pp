define lamp::db(
  $db_user,
  $db_password,
  $host = $::fqdn,
  $port = 3306,
  $database = $name,
)

{

  include mysql::bindings::php

  mysql::db { $name:
    user     => $db_user,
    password => $db_password,
  }


  if ! defined(Class['lamp::db_common']) {
    class { 'lamp::db_common':
      db_user     => $db_user,
      db_password => $db_password,
      host        => $host,
      port        => $port,
      database    => $database,
    }

  }

}
Lamp::Db produces Sql {
  user     => $db_user,
  password => $db_password,
  host     => $host,
  database => $name,
  port     => $port
}
