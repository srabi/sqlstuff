DECLARE @count_cmd VARCHAR(200), @table_name VARCHAR(200);

DECLARE @result TABLE ([table_name] VARCHAR(200), [table_type] VARCHAR(200), [rowcount] INT);

DECLARE tables_cursor CURSOR FOR
SELECT CONCAT('SELECT ''', table_name,''', ''', table_type,''', COUNT(*) FROM ', table_name, ';')
FROM   INFORMATION_SCHEMA.TABLES;

OPEN tables_cursor;

FETCH NEXT FROM tables_cursor
INTO @count_cmd;

WHILE @@FETCH_STATUS = 0
BEGIN
    print @count_cmd;
    INSERT INTO @result
    EXEC (@count_cmd);

    FETCH NEXT FROM tables_cursor
    INTO @count_cmd;
END

CLOSE tables_cursor;
DEALLOCATE tables_cursor;

SELECT * FROM @result
ORDER BY [rowcount] DESC;

