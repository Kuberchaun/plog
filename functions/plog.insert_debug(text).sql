-- Function: plog.insert_debug(text)

-- DROP FUNCTION plog.insert_debug(text);

CREATE OR REPLACE FUNCTION plog.insert_debug(log_text text)
  RETURNS void AS
$BODY$
BEGIN
    INSERT INTO plog.the_log(the_log_level_id,the_log_text,username) VALUES( 1,log_text,current_user);
    RETURN;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION plog.insert_debug(text)
  OWNER TO postgres;
