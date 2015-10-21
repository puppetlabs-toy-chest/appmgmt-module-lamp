application lamp (
  $db_user,
  $db_password,
  $web_count = 2,
) {
  $webs = $web_count.map |$i| { Http["lamp-${name}-${i}"] }

  $webs.each |$i, $web| {
    site::apache { "${name}-${i}":
      export => $web,
    }
  }
  ## An example of that capability resource
  # http {'three':
  #   host => "el1.vm",
  #   ip   => "172.16.89.222",
  #   port => 80,
  # }

  site::lb { "lamp-lb-${name}":
    balancermembers => $webs,
    port            => 80,
    require         => $webs,
    export          => Http["lamp-lb-${name}"],
  }

  site::pql { $name:
    user     => $db_user,
    password => $db_password,
    export   => Sql[$name],
  }

}
