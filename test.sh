#!/bin/bash

# Determine OS architecture
if [[ "$(uname -m)" == "x86_64" ]]; then
  mysql_package="mysql-server"
else
  mysql_package="mysql-server-5.7"
fi

# Install MySQL
apt-get update
apt-get install -y $mysql_package

# create database, table, and insert data
mysql -u root -p << EOF
CREATE DATABASE testtask;
USE testtask;
CREATE TABLE students (id INT NOT NULL AUTO_INCREMENT, name VARCHAR(30) NOT NULL, email VARCHAR(30) NOT NULL, PRIMARY KEY (id));
INSERT INTO students (name, email) VALUES ('ritika', 'ritika@example.com'), ('shivani', 'shivani@example.com');
EOF

# Take backup of "testtask" database
mysqldump -u root -p testtask > testtask.sql

# Create tar file of backup and store it in /tmp directory
tar czf /tmp/testtask_backup.tar.gz testtask.sql
