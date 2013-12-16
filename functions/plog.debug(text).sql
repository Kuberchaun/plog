-- *********************************************************************************************
-- Description: -- Opens up a new transactions by creating a new connection
-- with dblink and commits to the log table the desired text to logging table regardless of parent 
-- transaction being rolled back.  Primarly for instrumenting code and in 
-- special cases doing batch commits for a large volume of data.
--
-- Input Parameters: log_text TEXT - The text you want to log to the logging table.
--
-- Output Parameters:  NA
--
-- Error Conditions Raised: NA
--
-- Author:      Bob Henkel bob.henkel@gmail.com
--
-- Revision History
-- Date            Author       Reason for Change
-- ----------------------------------------------------------------
-- 13-DEC-2013     Bob Henkel   Initial Version
-- *********************************************************************************************

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
    
    IF ( conn = 'dblink_logging' ) THEN
        SELECT * FROM public.dblink('dblink_logging','SELECT * FROM plog.insert_debug('''|| log_text || ''',''' || pid ||''')')  as result(void_output TEXT) INTO void;
    END IF;

    IF ( conn ISNULL ) THEN
        SELECT dblink_connect('dblink_logging','dbname=sandbox') INTO void;
        SELECT * FROM public.dblink('dblink_logging','SELECT * FROM plog.insert_debug('''|| log_text || ''',''' || pid ||''')')  as result(void_output TEXT) INTO void;
    END IF; 
    RETURN;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION plog.debug(text)
  OWNER TO postgres;
