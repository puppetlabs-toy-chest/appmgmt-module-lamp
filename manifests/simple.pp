application lamp::simple (
  $db_user,
  $db_password,
) {

  site::apache { 'lamp_apache':
    consume => Sql['lamp_mysql'],
    export  => Http['lamp_apache'],
  }

  site::mysql { 'lamp_mysql':
    db_user     => $db_user,
    db_password => $db_password,
    export   => Sql['lamp_mysql'],
  }

}
