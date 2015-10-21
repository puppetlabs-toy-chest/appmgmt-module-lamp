class lamp::db_common
(
  $db_user = $lamp::app::db_user,
  $db_password = $lamp::app::db_password,
  $host = $lamp::app::host,
  $port = $lamp::app::db_port,
  $database = $lamp::app::db_name,
) {

  class { 'mysql::server':
    override_options => {
      mysqld => { 'bind-address' => '0.0.0.0'} #Allow remote connections
    },
    grants => {
      "${db_user}@${host}/${database}.*" => {
        ensure     => present,
        options    => ['GRANT'],
        privileges => ['SELECT', 'INSERT', 'UPDATE', 'DELETE'],
        table      => "${database}.*",
        user       => "${db_user}@${host}",
      },
    }
  }

}
