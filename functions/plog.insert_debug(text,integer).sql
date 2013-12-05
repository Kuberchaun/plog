-- Function: plog.insert_debug(text, integer)

-- DROP FUNCTION plog.insert_debug(text, integer);

CREATE OR REPLACE FUNCTION plog.insert_debug(log_text text, p_pid integer)
  RETURNS void AS
$BODY$
BEGIN
    INSERT INTO plog.the_log(the_log_level_id,the_log_text,username, log_pid) VALUES( 1,log_text,current_user,p_pid);
    RETURN;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION plog.insert_debug(text, integer)
  OWNER TO postgres;
