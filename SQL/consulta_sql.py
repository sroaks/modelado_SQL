import pyodbc
import pandas as pd
from statsmodels.tsa.arima.model import ARIMA
import matplotlib.pyplot as plt

# Configura la conexión
server = 'PRA_GENERAL\SQLEXPRESS'
database = 'Prueba DB'

conn = pyodbc.connect('DRIVER={SQL Server};SERVER='+server+';DATABASE='+database+';Trusted_Connection=yes')

query = """
SELECT *
FROM dbo.VENTAS_TOTALES
"""

# Ejecutar la consulta y cargar los resultados en un DataFrame
df_ventas = pd.read_sql(query, conn)

# Cierra la conexión después de usarla
conn.close()

# Preparación de datos en Python
print(df_ventas.head())

query = """
SELECT *
FROM dbo.VENTAS_TOTALES
"""


# Cargar los datos desde el archivo Excel
df = pd.read_excel('prueba_sql.xlsx')