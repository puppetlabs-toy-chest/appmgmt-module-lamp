application lamp (
  $parameter = 'default',
){

  site::apache { 'one':
    export => Http['one'],
  }
  site::apache { 'two':
    export => Http['two'],
  }
  site::apache { 'three':
    export => Http['three'],
  }
  ## An example of that capability resource
  # http {'three':
  #   host => "el1.vm",
  #   ip   => "172.16.89.222",
  #   port => 80,
  # }

  $http_members = [
    Http['one'],
    Http['two'],
    Http['three']
  ]
  site::lb { $name:
    balancermembers => $http_members,
    consume         => $http_members,
  }

  site::pql { $name:
    user     => 'ryan',
    password => 'pass',
    export   => Sql['foo'],
  }

}
