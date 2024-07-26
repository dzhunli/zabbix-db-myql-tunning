SELECT ho.hostid, ho.name, count(*) AS records, 
(count(*)* (SELECT AVG_ROW_LENGTH FROM information_schema.tables 
WHERE TABLE_NAME = 'history_text' and TABLE_SCHEMA = 'zabb')/1024/1024) AS 'Total size average (Mb)', 
sum(length(history_text.value))/1024/1024 + sum(length(history_text.clock))/1024/1024 + sum(length(history_text.ns))/1024/1024 + sum(length(history_text.itemid))/1024/1024 AS 'history_text Column Size (Mb)'
FROM history_text
LEFT OUTER JOIN items i on history_text.itemid = i.itemid 
LEFT OUTER JOIN hosts ho on i.hostid = ho.hostid 
WHERE ho.status IN (0,1)
AND clock > UNIX_TIMESTAMP(now() - INTERVAL 1 DAY - INTERVAL 60 MINUTE)
AND clock < UNIX_TIMESTAMP(now() - INTERVAL 1 DAY)
GROUP BY ho.hostid
ORDER BY 4 DESC
LIMIT 5\G
