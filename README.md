# Dicoth
An open source forum system written in D Programming Language, based on Hunt Framework.

## Install

### Create Database
This forum using MySQL database, you can create database name `dicoth` and import tables scheme:
```SQL
source ./data/mysql/scheme.sql
```

### Edit Config
You need edit config item for your project, http port, database information and more, project file:
```sh
vim config/application.conf
```

### Runt Dicoth
```sh
cd dicoth/
dub run -v
```
