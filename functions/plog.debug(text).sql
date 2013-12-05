-- Function: plog.debug(text)

-- DROP FUNCTION plog.debug(text);

CREATE OR REPLACE FUNCTION plog.debug(log_text text)
  RETURNS void AS
$BODY$
DECLARE
void TEXT;
conn TEXT;
pid  INTEGER := pg_backend_pid();
BEGIN
    SELECT dblink_get_connections[1] into conn
    FROM dblink_get_connections()
    WHERE dblink_get_connections[1] = 'dblink_logging';
    --RAISE NOTICE 'value of conn %', conn;
    IF ( conn = 'dblink_logging' ) THEN
        SELECT * FROM public.dblink('dblink_logging','SELECT * FROM plog.insert_debug('''|| log_text || ''',''' || pid ||''')')  as result(void_output TEXT) INTO void;
        --SELECT dblink_disconnect('dblink_logging') INTO void;
        --RAISE NOTICE 'connection found';
    END IF;

    IF ( conn ISNULL ) THEN
        SELECT dblink_connect('dblink_logging','dbname=sandbox') INTO void;
        SELECT * FROM public.dblink('dblink_logging','SELECT * FROM plog.insert_debug('''|| log_text || ''',''' || pid ||''')')  as result(void_output TEXT) INTO void;
        --SELECT dblink_disconnect('dblink_logging') INTO void; 
        --RAISE NOTICE 'connection isnull';
    END IF; 
    RETURN;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION plog.debug(text)
  OWNER TO postgres;
