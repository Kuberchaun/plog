  INSERT INTO plog.log_level(log_level_id, log_level, log_description )
  SELECT 1,'DEBUG','Used by DBA and developers to put in text aides in debugging'
  UNION ALL
  SELECT 2,'LOG','General type of log used to instrument the code.'
  UNION ALL
  SELECT 3,'INFO','Used to add any commentary to the code that you want to show up in the log.'
  UNION ALL
  SELECT 4,'NOTICE','Any commentary that may of be of special importanct. For example "yearly reports processing has completed!" is one example.'
  UNION ALL
  SELECT 5,'WARNING','Anything you want to label as a warning condition such as supply of oranges is getting low'
  UNION ALL
  SELECT 6,'EXCEPTION','When exceptional things happen log them with this';