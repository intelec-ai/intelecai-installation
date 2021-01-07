drop table IF exists `file_inference`;

create table file_inference (
  `id` integer auto_increment ,
  `file_path` VARCHAR(1000) NOT NULL,
  `task_id` integer,
  `result` VARCHAR(500),
  `file_lastmodified_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX task_id (task_id),
  INDEX result (result),
  UNIQUE filePath_taskId_fileLastmodified (file_path, task_id, file_lastmodified_at)
);

drop table IF exists `tasks`;

create table tasks (
  `id` integer auto_increment ,
  `name` VARCHAR(200) NOT NULL,
  `type` VARCHAR(100) NOT NULL,
  `user_id` INTEGER NOT NULL REFERENCES users(id),
  `details` VARCHAR(5000),
  `running` BOOLEAN DEFAULT TRUE,
  `task_created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
);

drop table IF exists `common_info`;

create table common_info (
  `name` VARCHAR(200) NOT NULL,
  `value` VARCHAR(5000),
  PRIMARY KEY (`name`)
);

drop table IF exists `users`;

create table users (
  `id` integer NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(200) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE username (username)
);

drop table IF exists `sessions`;

create table sessions (
  `id` integer NOT NULL AUTO_INCREMENT,
  `token` varchar(50),
  `user_id` integer NOT NULL REFERENCES users(id),
  PRIMARY KEY (`id`),
  UNIQUE token (token)
);

CREATE USER 'app_user'@'%' IDENTIFIED BY 'appy_pass1';
GRANT SELECT,INSERT,UPDATE,DELETE ON intelec_ai.* TO 'app_user'@'%';

FLUSH PRIVILEGES;