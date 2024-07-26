SELECT hosts.host,items.itemid,items.key_,
COUNT(history.itemid)  AS 'count', AVG(LENGTH(history.value)) AS 'avg size',
(COUNT(history.itemid) * AVG(LENGTH(history.value))) AS 'Count x AVG'
FROM history
JOIN items ON (items.itemid=history.itemid)
JOIN hosts ON (hosts.hostid=items.hostid)
WHERE clock > UNIX_TIMESTAMP(NOW() - INTERVAL 30 MINUTE)
GROUP BY hosts.host,history.itemid
ORDER BY 6 DESC
LIMIT 1\G
