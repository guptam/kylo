create database if not exists thinkbig;
use thinkbig;
create table CHANGE_SET (id binary(16) not null, created_time datetime, modified_time datetime, completeness_factor integer, intrinsic_period varchar(255), intrinsic_time datetime, dataset_id binary(16), primary key (id)) ENGINE=InnoDB;
create table CHANGE_SET_FILES (id binary(16) not null, primary key (id)) ENGINE=InnoDB;
create table CHANGE_SET_FILES_PATH (change_set_files_id binary(16) not null, path varchar(255)) ENGINE=InnoDB;
create table CHANGE_SET_HIVE_TABLE (record_count integer, id binary(16) not null, primary key (id)) ENGINE=InnoDB;
create table CHANGE_SET_HIVE_TABLE_PART_VALUE (change_set_hive_table_id binary(16) not null, name varchar(255), value varchar(255)) ENGINE=InnoDB;
create table DATA_OPERATION (id binary(16) not null, created_time datetime, modified_time datetime, start_time datetime, state varchar(15), status varchar(2048), stop_time datetime, dataset_id binary(16), producer_id binary(16), primary key (id)) ENGINE=InnoDB;
create table DATASET (id binary(16) not null, created_time datetime, modified_time datetime, type varchar(10), datasource_id binary(16), primary key (id)) ENGINE=InnoDB;
create table DATASOURCE (type varchar(31) not null, id binary(16) not null, created_time datetime, modified_time datetime, description varchar(255), name varchar(100), database_name varchar(255), table_name varchar(255), path varchar(255), primary key (id)) ENGINE=InnoDB;
create table FEED (id binary(16) not null, created_time datetime, modified_time datetime, description varchar(255), display_name varchar(100), initialized char(1), name varchar(100) not null, state varchar(10) not null, sla_id binary(16), primary key (id)) ENGINE=InnoDB;
create table FEED_DESTINATION (id binary(16) not null, created_time datetime, modified_time datetime, datasource_id binary(16), feed_id binary(16), primary key (id)) ENGINE=InnoDB;
create table FEED_PROPERTIES (JpaFeed_id binary(16) not null, prop_value varchar(255), prop_key varchar(100) not null, primary key (JpaFeed_id, prop_key)) ENGINE=InnoDB;
create table FEED_SOURCE (id binary(16) not null, created_time datetime, modified_time datetime, datasource_id binary(16), feed_id binary(16), agreement_id binary(16), primary key (id)) ENGINE=InnoDB;
create table SLA (id binary(16) not null, created_time datetime, modified_time datetime, description varchar(255), name varchar(100), primary key (id)) ENGINE=InnoDB;
create table SLA_METRIC (id binary(255) not null, created_time datetime, modified_time datetime, metric varchar(255), obligation_id binary(16), primary key (id)) ENGINE=InnoDB;
create table SLA_OBLIGATION (id binary(16) not null, created_time datetime, modified_time datetime, description varchar(255), group_id binary(16), primary key (id)) ENGINE=InnoDB;
create table SLA_OBLIGATION_GROUP (id binary(16) not null, created_time datetime, modified_time datetime, cond varchar(10), agreement_id binary(16), primary key (id)) ENGINE=InnoDB;

CREATE TABLE `FM_CATEGORY` (
  `id` binary(16) NOT NULL,
  `created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `description` varchar(255) DEFAULT NULL,
  `system_name` varchar(100) NOT NULL,
  `display_name` varchar(100) DEFAULT NULL,
  `json` mediumtext,
  `state` varchar(45) DEFAULT 'ENABLED',
  `icon` varchar(45) DEFAULT NULL,
  `icon_color` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;


CREATE TABLE `FM_FEED` (
  `id` binary(16) NOT NULL,
  `created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `feed_id` binary(16) NOT NULL,
  `json` mediumtext,
  `category_id` binary(16) NOT NULL,
  `template_id` binary(16) NOT NULL,
  `state` varchar(45) DEFAULT 'ENABLED',
  `version` int(11) DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `feed_id_UNIQUE` (`feed_id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB;

CREATE TABLE `FM_TEMPLATE` (
  `id` binary(16) NOT NULL,
  `created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `description` varchar(255) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `state` varchar(10) DEFAULT 'ENABLED',
  `is_define_table` varchar(1) DEFAULT NULL,
  `is_data_transform` varchar(1) DEFAULT NULL,
  `allow_preconditions` varchar(1) DEFAULT NULL,
  `json` mediumtext NOT NULL,
  `nifi_template_id` varchar(45) DEFAULT NULL,
  `icon` varchar(45) DEFAULT NULL,
  `icon_color` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



CREATE TABLE NIFI_PIPELINE_CONTROLLER_STEP  (
  EVENT_ID BIGINT NOT NULL PRIMARY KEY,
     NIFI_EVENT_ID BIGINT,
     COMPONENT_ID VARCHAR(255),
 JOB_EXECUTION_ID BIGINT,
 STEP_EXECUTION_ID BIGINT
 ) ENGINE=InnoDB;


     CREATE TABLE NIFI_PIPELINE_CONTROLLER_JOB  (
     EVENT_ID BIGINT NOT NULL PRIMARY KEY,
     NIFI_EVENT_ID BIGINT,
     FLOW_FILE_UUID VARCHAR(255),
     FEED_ID BIGINT,
     FEED_NAME VARCHAR(255),
     JOB_INSTANCE_ID BIGINT,
     JOB_EXECUTION_ID BIGINT
     ) ENGINE=InnoDB;
