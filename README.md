# MyCV-WS
A  Ruby on Rails Web service that signs you up with some Identity Providers, 
collect personal data from those profiles and use them to create an Europass CV 
based, moreover it searches for job offers compatible with your skills and create a 
CV version for each type of application. At the end it will try to update your cv in 
your personal Google Drive account.

### Setting PostgreSql

* [Install PostgreSql 9.6.9](https://www.postgresql.org/download/macosx)
(also higher versions should be fine)
* Enter psql tool
```bash
 $ psql postgres
 
 psql (9.6.9, server 10.4)
 postgres=# 
```
* Add new postgres user
```
postgres=# CREATE ROLE admin WITH LOGIN PASSWORD 'admin';
```
* Add permissions to `admin` user 
```
postgres=# ALTER ROLE admin CREATEDB; 
postgres=# ALTER ROLE admin SUPERUSER; 
```
* Check postgres users
```
postgres=# \du
 
 Role name |                         Attributes                         | Member of 
-----------+------------------------------------------------------------+-----------
 admin     | Superuser, Create DB                                       | {}
 postgres  | Superuser, Create role, Create DB, Replication, Bypass RLS | {}
```
* Quit `psql`
```
postgres=# \q
```

### Setting encripted app secrets

* Modify `config/credentials.yml.enc` 
(is the file that will contain our application secret keys),
in this way
```
$ EDITOR=nano rails credentials:edit
```
