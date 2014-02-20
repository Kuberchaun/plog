plog
====

Simple logging framework for PostgreSQL.  The logging statements are committed in an autonomous transaction seperate from the surronding transaction. This alllows the outer transaction to rollback or commit, but for the logging statements to still commit the log table.  This is one of the few cases autonomous transactions should be made use of. Aside from that if you are using them most likely you need to ask what it is your really trying to accomplish.

Requires:
<tt>CREATE EXTENSION dblink;

I assume at this point you have executed the schema script followed by the tables, functions, and inserts respectively.


Example1(Make sure everything is working):

<tt>BEGIN TRANSACTION;

<tt>CREATE TABLE xyz();

<tt>select plog.debug('I was logged!');

<tt>ROLLBACK TRANSACTION;


--Will return error that table doesn't exist because we rollbacked the transaction.
<tt>select * from xyz; 

--WIll return 1 row because the logging call was commited on its own transaction.
<tt>select * from plog.the_log;

This proves the outer transaction rolled back while the inner transaction committed to our log table.

Nothing is free and for every feature there's overhead so test and decide if this is worth it when you want to do this.

I'm still working on cleaning up the scripts so this is a work in progress, but still of value for those needing
something like Oracle PLSQL AutonomousTransactions in PostgreSQL.


