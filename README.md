# LAMP

#### Table of Contents

1. [Description](#description)
1. [Setup](#setup-requirements)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Limitations - OS compatibility, etc.](#limitations)


## Description

Example LAMP application module for use with Puppet Application Orchestration on CentOS.

The application provided by this module can be used to deploy and manage a simple LAMP stack that includes a MySQL database (provided by puppetlabs-mysql) and an Apache HTTP web server (provided by puppetlabs-apache) hosting a sample PHP application. These components can be declared onto one host or spread across two.

## Setup Requirements

It's recommended that you start by reading [documentation](https://docs.puppetlabs.com/pe/latest/app_orchestration_overview.html) for application orchestration with puppet. You'll need to be using Puppet Enterprise 2015.3.1 and have enabled application orchestration to use this module.

## Usage

Here's a simple application instance declaration (for your site manifest) that places the database on a separate node from the web server and application.

```
lamp { 'stack':
  db_user     => 'stack',
  db_password => 'exchange',
  nodes => {
    Node['node.one.domain'] => [ Lamp::Web['stack'], Lamp::App['stack'] ],
    Node['node.two.domain'] => Lamp::Db['stack'],
  }
 }
```

 For situations like development, it can be useful to assign all application components to a single node, like the following.

```
 lamp { 'stack':
   db_user     => 'stack',
   db_password => 'exchange',
   nodes => {
     Node['node.allinone.domain'] => [
      Lamp::Web['stack'],
      Lamp::App['stack'],
      Lamp::Db['stack']
     ],
   }
  }
```

In both cases, the [puppet orchestrator](https://docs.puppetlabs.com/pe/latest/orchestrator_intro.html) can be used to configure the nodes participating in the LAMP application.

## Limitations

This module is provided as an example of what's possible with the [Puppet language features for distributed application management](https://docs.puppetlabs.com/pe/latest/app_orchestration_overview.html#language-extensions-for-application-orchestration-an-overview). No support is provided for this Puppet module though it will be available on the Forge in the future.
