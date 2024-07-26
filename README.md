# zabbix-db-myql-tunning
[![gen image](https://github.com/dzhunli/zabbix-db-myql-tunning/actions/workflows/docker-image.yml/badge.svg)](https://github.com/dzhunli/zabbix-db-myql-tunning/actions/workflows/docker-image.yml)
![Python Version](https://img.shields.io/badge/Python-3.8-blue)
![Zabbix Version](https://img.shields.io/badge/Zabbix-7.0.2-red)

---
## Why is this necessary?
  -  Efficient Data Management: Regularly updating history and trends values to optimal durations reduces the volume of stored data.

  -  Improved Query Performance: Smaller datasets enhance query speed and reduce latency.

  -  Resource Optimization: Lower storage requirements lead to reduced disk space usage and better resource management.

  -  Automated Maintenance: Using environment variables for replacement values allows for easy adjustments and automated database maintenance.

## Requirements
1.  You need to have sufficient access to the Zabbix database.

2. You must install some packages for the emulator to work:
  -  docker --> please visit https://docs.docker.com/engine/install/ (you don`t need docker desktop ONLY docker engine)

## Usage
1. Enter the required values ​​into the file with variables, it is called: ```envfile```

2. Run the following command:  

    ```docker run --name zabbix-db-myql-tunning --env-file envfile --network=host dzhunli/zabbix-sql-tun:latest```

3. When the tuning is completed, the container will stop working by itself.

### Explanation of variables

| Var  | Description        |
|----------|--------------------|
| DB_HOST | Database host address |
| DB_PORT |  Database port number (default: 3306)  |
| DB_NAME | Database name |
| DB_USER |  Database username (zabbix db username) |
| DB_PASSWORD | Database user password (zabbix db password) |
| HISTORY_VALUE | Replacement value for history |
| TRENDS_VALUE | Replacement value for trends |



## Addition
