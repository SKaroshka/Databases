CREATE DATABASE IF NOT EXISTS campus_web;
CREATE USER IF NOT EXISTS 'kasobko'@'localhost' IDENTIFIED BY 'securepass';
GRANT ALL PRIVILEGES ON campus_web.* TO 'kasobko'@'localhost';
FLUSH PRIVILEGES;
