-- Table: plog.the_log

-- DROP TABLE plog.the_log;

CREATE TABLE plog.the_log
(
  the_log_id bigserial NOT NULL,
  the_log_date timestamp without time zone NOT NULL DEFAULT now(),
  the_log_level_id integer NOT NULL,
  the_log_text text NOT NULL,
  username name NOT NULL,
  log_pid integer,
  CONSTRAINT pk_the_log PRIMARY KEY (the_log_id )
)
WITH (
  OIDS=FALSE
);
ALTER TABLE plog.the_log
  OWNER TO postgres;
