create table file_inference (
  `id` integer auto_increment ,
  `file_path` VARCHAR(1000) NOT NULL,
  `deployed_model_id` integer,
  `result` VARCHAR(500),
  `file_created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX deployed_model_id (deployed_model_id),
  INDEX result (result)
);

create table tasks (
  `id` integer auto_increment ,
  `name` VARCHAR(200) NOT NULL,
  `type` VARCHAR(100) NOT NULL,
  `task_created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `details` VARCHAR(5000),
  PRIMARY KEY (`id`)
);

create table common_info (
  `name` VARCHAR(200) NOT NULL,
  `value` VARCHAR(5000),
  PRIMARY KEY (`name`)
);

CREATE USER 'app_user'@'%' IDENTIFIED BY 'app_user_password';
GRANT SELECT,INSERT,UPDATE,DELETE ON intelec_ai.* TO 'app_user'@'%';

CREATE USER 'report_user'@'%' IDENTIFIED BY 'report_user_password';
GRANT SELECT ON intelec_ai.file_inference TO 'report_user'@'%';

FLUSH PRIVILEGES;