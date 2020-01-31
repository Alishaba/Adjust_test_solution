import matplotlib.pyplot as plt
import pandas as pd
import pandas.io.sql as sqlio
import psycopg2

conn = psycopg2.connect(host="localhost", port='5422', database='postgres', user='postgres')
cur = conn.cursor()

# Execute the query and print the results
cur.execute("SELECT country, SUM(installs) AS Sum_of_paid_installs FROM installs_by_country WHERE "
            "((created_at LIKE '2019-05%') AND (paid=True)) GROUP BY country ORDER BY Sum_of_paid_installs")
rows = cur.fetchall()
df2 = pd.DataFrame(rows, columns=['columns', 'Sum_of_paid_installs'])
print(df2)

# Import the data and process using Pandas
sql = "select * from installs_by_country;"
df = sqlio.read_sql_query(sql, conn)
df1 = df[(df['paid'] == True) * (pd.to_datetime(df['created_at'].values).year == 2019) * (
        pd.to_datetime(df['created_at'].values).month == 5)].groupby('country')['installs'].sum().sort_values()
print(df1)

# Plot the amount of installs per country for May 2019
df1.plot(kind='bar', ylim=(0.95 * min(df1), 1.05 * max(df1)))
plt.ylabel('Amount of paid installs in May 2019')
plt.show()

# Close cursor
cur.close()

# Close connection
conn.close()
