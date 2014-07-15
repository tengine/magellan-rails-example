#  magellan-rails

## Install into rails project

1. add `gem "magellan-rails"` into Gemfile
2. bundle install
3. rails generate magellan:install
   # => generate Dockerfile and Magellan.yml



## Edit Magellan.yml

(under construction)

add DB or Application Server container


### examples

#### mysql

```
mysql:
  image: mysql
  Dockerfile: https://raw.githubusercontent.com/docker-library/docker-mysql/master/Dockerfile
```




## Edit configurations

`magellan env` show list of ENVironment variables set by docker.

```
$ magellan env
MYSQL_PORT_3306_TCP_ADDR=172.12.0.4
MYSQL_PORT_3306_TCP_PORT=9999
```

Now you must edit configuration files to use above environment variables.

for more exmple https://github.com/akm/rails_admin_example2/blob/master/config/database.yml#L54





## Run in local

`magellan start local` run each container in Magellan.yml
