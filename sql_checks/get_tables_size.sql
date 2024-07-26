SELECT table_name,
       table_rows,
       data_length,
       index_length,
       round(((data_length + index_length) / 1024 / 1024 / 1024),2) "Size in GB"
FROM information_schema.tables
WHERE table_schema = "zabb"
ORDER BY round(((data_length + index_length) / 1024 / 1024 / 1024),2) DESC
LIMIT 10;
