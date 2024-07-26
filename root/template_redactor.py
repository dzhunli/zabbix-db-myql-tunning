import csv
import mysql.connector
import os

try:
    # Database connection parameters
    db_port = os.environ.get("DB_PORT", "3306")
    db_host = os.environ.get("DB_HOST")
    db_user = os.environ.get("DB_USER")
    db_password = os.environ.get("DB_PASSWORD")
    db_name = os.environ.get("DB_NAME")
    # Replacement values from environment variables
    replace_history_value = os.environ.get("HISTORY_VALUE", "30d")
    replace_trends_value = os.environ.get("TRENDS_VALUE", "183d")

    connection = mysql.connector.connect(
        host=db_host,
        port=db_port,
        user=db_user,
        password=db_password,
        database=db_name
    )

    cursor = connection.cursor()

    select_query_history = f"""
        SELECT itemid, name, hostid
        FROM items
        WHERE `history` > '{replace_history_value}';
    """

    cursor.execute(select_query_history)
    result_history = cursor.fetchall()

    update_query_history = f"""
        UPDATE items
        SET `history` = '{replace_history_value}'
        WHERE itemid = %s;
    """
    select_query_trends = f"""
        SELECT itemid, name, hostid
        FROM items
        WHERE `trends` > '{replace_trends_value}';
    """
    cursor.execute(select_query_trends)
    result_trends = cursor.fetchall()

    update_query_trends = f"""
        UPDATE items
        SET `trends` = '{replace_trends_value}'
        WHERE itemid = %s;
    """

    csv_file_path = 'data/updated_items_data.csv'
    with open(csv_file_path, 'w', newline='') as csvfile:
        csv_writer = csv.writer(csvfile)
        csv_writer.writerow(['itemid', 'name', 'hostid'])

        for row in result_history:
            itemid, name, hostid = row
            cursor.execute(update_query_history, (itemid,))
            connection.commit()
            csv_writer.writerow([itemid, name, hostid])

        for row in result_trends:
            itemid, name, hostid = row
            cursor.execute(update_query_trends, (itemid,))
            connection.commit()
            csv_writer.writerow([itemid, name, hostid])

    print("Updating and saving data to CSV completed")

except mysql.connector.Error as err:
    print(f"MySQL Error: {err}")

finally:
    if 'connection' in locals() and connection.is_connected():
        cursor.close()
        connection.close()
        print("Connection to MySQL closed")

