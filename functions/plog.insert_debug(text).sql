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
