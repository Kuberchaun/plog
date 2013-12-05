plog
====

Simple logging framework for PostgreSQL.  The logging is commited in an autonomous transaction. This alllows the outer transaction to rollback, but for the logging to still commit.


Requires:
CREATE EXTENSION dblink;


Example1(Make sure everything is working):
BEGIN TRANSACTION;
CREATE TABLE xyz();
select plog.debug('I was logged!');
ROLLBACK TRANSACTION;

select * from xyz; --Will return error that table doesn't exist because we rollbacked the transaction.
select * from plog.the_log;--WIll return 1 row because the logging call was commited on its own transaction.


