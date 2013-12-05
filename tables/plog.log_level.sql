-- Table: plog.log_level

-- DROP TABLE plog.log_level;

CREATE TABLE plog.log_level
(
  log_level_id integer NOT NULL,
  log_level character varying(50) NOT NULL,
  log_description character varying(250) NOT NULL,
  CONSTRAINT pk_plog PRIMARY KEY (log_level_id )
)
WITH (
  OIDS=FALSE
);
ALTER TABLE plog.log_level
  OWNER TO postgres;
