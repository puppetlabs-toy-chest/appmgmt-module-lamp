define lamp::app (
  $docroot,
  $db_name,
  $db_port,
  $db_user,
  $db_host,
  $db_password,
  $host = $::fqdn,
) {

  package { 'php-mysql':
    ensure => installed,
    notify => Service['httpd'],
  }

  include apache::mod::php

  file { "${docroot}/index.html":
    ensure  => file,
    content => template('lamp/index.html.erb'),
  }

  $indexphp = @("INDEXPHP"/)
    <?php
    // Create connection
    \$conn = mysql_connect($db_host, $db_user, $db_password);

    // Check connection
    if (\$conn->connect_error) {
        die("Connection failedto $db_host as $db_user: " . \$conn->connect_error);
    }
    echo "Connected successfully to $db_host as $db_user";
    ?>
  INDEXPHP


  file { "${docroot}/index.php":
    ensure  => file,
    content => $indexphp,
  }

}
Lamp::App consumes Sql {
  db_name     => $name,
  db_port     => $port,
  db_user     => $user,
  db_host     => $host,
  db_password => $password,
}
