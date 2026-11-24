DROP DATABASE IF EXISTS creative_db;
CREATE DATABASE creative_db
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

CREATE USER IF NOT EXISTS 'kasobko'@'localhost' IDENTIFIED BY 'securepass';
GRANT ALL PRIVILEGES ON creative_db.* TO 'kasobko'@'localhost';
FLUSH PRIVILEGES;