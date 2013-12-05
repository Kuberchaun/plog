plog
====

Simple logging framework for PostgreSQL.  The logging is commited in an autonomous transaction. This alllows the outer transaction to rollback, but for the logging to still commit.


Requires:
<tt>CREATE EXTENSION dblink;


Example1(Make sure everything is working):

<tt>BEGIN TRANSACTION;

<tt>CREATE TABLE xyz();

<tt>select plog.debug('I was logged!');

<tt>ROLLBACK TRANSACTION;


--Will return error that table doesn't exist because we rollbacked the transaction.
<tt>select * from xyz; 

--WIll return 1 row because the logging call was commited on its own transaction.
<tt>select * from plog.the_log;


