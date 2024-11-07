import tkinter as tk
import pandas as pd
import re

# Función para convertir binario a decimal, si el valor es un binario válido
def binario_a_decimal(valor_binario):
    valor_binario = str(valor_binario).strip()
    # Validar si el valor es un número binario
    if re.fullmatch(r'[01]+', valor_binario):
        return int(valor_binario, 2)
    return None  # Si no es binario, retorna None

# Función para convertir decimal a binario, asegurando que tenga un número fijo de bits
def decimal_a_binario(valor_decimal, bits):
    if pd.isna(valor_decimal):
        return None  # Si es NaN, retorna None
    return format(int(valor_decimal), f'0{bits}b')  # Convierte a binario con ceros a la izquierda

# Función para convertir los datos del archivo Excel
def convertir_datos():
    try:
        df = pd.read_excel('Book1.xlsx')  # Cambia la ruta si es necesario
        # Eliminar espacios en blanco en los nombres de columnas y reemplazar NaN
        df.columns = df.columns.str.strip()
        print("Columnas del DataFrame:", df.columns)  # Verificar los nombres de las columnas
        df.columns = ['op 6', 'rs 5', 'rt 5', 'rd 5', 'shawt 5', 'funct 6']  # Ajustar nombres si es necesario

        # Convertir las columnas de decimal a binario
        df['op 6'] = df['op 6'].apply(lambda x: decimal_a_binario(x, 6))
        df['rs 5'] = df['rs 5'].apply(lambda x: decimal_a_binario(x, 5))
        df['rt 5'] = df['rt 5'].apply(lambda x: decimal_a_binario(x, 5))
        df['rd 5'] = df['rd 5'].apply(lambda x: decimal_a_binario(x, 5))
        df['shawt 5'] = df['shawt 5'].apply(lambda x: decimal_a_binario(x, 5))
        df['funct 6'] = df['funct 6'].apply(lambda x: decimal_a_binario(x, 6))

        # Filtrar solo filas con datos válidos
        df_filtrado = df.dropna(subset=['op 6', 'rs 5', 'rt 5', 'rd 5', 'shawt 5', 'funct 6'])

        # Guardar los datos convertidos en un archivo .txt
        archivo_salida = '32instructions.txt'
        with open(archivo_salida, 'w') as f:
            for index, row in df_filtrado.iterrows():
                # Cambiamos el orden y formato según lo solicitado
                f.write(f"{row['op 6']}{row['rs 5']}{row['rt 5']}{row['rd 5']}{row['shawt 5']}{row['funct 6']}\n")

        etiqueta.config(text=f"Datos convertidos y guardados en: {archivo_salida}")

    except Exception as e:
        etiqueta.config(text=f"Error: {e}")

# Función para leer y mostrar datos de Excel
def leer_excel():
    try:
        df = pd.read_excel('Book1.xlsx')  # Cambia la ruta si es necesario
        print(df)  # Muestra los datos en la consola
        etiqueta.config(text="Datos leídos correctamente")
    except Exception as e:
        etiqueta.config(text=f"Error: {e}")

# Crear la ventana principal
ventana = tk.Tk()
ventana.title("Lectura y Conversión de Excel")
ventana.geometry("700x400")

# Crear una etiqueta
etiqueta = tk.Label(ventana, text="Presiona el botón para leer datos")
etiqueta.pack(pady=10)

# Crear un botón para leer Excel
boton_leer = tk.Button(ventana, text="Leer Excel", command=leer_excel)
boton_leer.pack(pady=10)

# Crear un botón para convertir los datos
boton_convertir = tk.Button(ventana, text="Convertir Datos", command=convertir_datos)
boton_convertir.pack(pady=10)

# Ejecutar el bucle principal
ventana.mainloop()
