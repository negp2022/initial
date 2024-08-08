import tiktoken

encoding = tiktoken.encoding_for_model("gpt-4")

#ruta_archivo = "data/EstructuraBDReducidaAbcdin.txt"

#ruta_archivo = "data/estructuraMongoExmaxReducida.json"

ruta_archivo = "data/estructuraMongoExmaxReducidaItems.txt"

with open(ruta_archivo, 'r') as archivo:
    texto = archivo.read()

print(texto)

# Tokenizar el texto
tokens = encoding.encode(texto)
numero_de_tokens = len(tokens)

print(f"Número de tokens: {numero_de_tokens}")

# Costos por 1,000 tokens
costo_por_1000_tokens = 0.0050  # Este es un ejemplo, asegúrate de usar el costo actual del modelo que estás usando

# Calcular el costo total
costo_estructura = (numero_de_tokens / 1000) * costo_por_1000_tokens

print(f"Costo estructura: ${costo_estructura:.4f}")
texto_pregunta = """
¿Cuál es la cantidad total de ventas en términos monetarios, el número de transacciones realizadas, el promedio de ventas por transacción, el monto total de descuentos aplicados, el número de clientes únicos que realizaron compras, el promedio de productos por transacción, el monto total de impuestos recaudados, el promedio de tiempo entre la primera y la última compra de cada cliente, y el monto total de ventas para cada categoría de producto, desglosado por mes y por región, durante los últimos cinco años, considerando solo aquellas transacciones que incluyeron productos en promoción y aplicando el filtro de excluir devoluciones y reembolsos?
"""
tokens_consulta = len(encoding.encode(texto_pregunta)) * 2
print(f"Tokens pregunta {tokens_consulta}")
costo_consulta = ((numero_de_tokens + tokens_consulta) / 1000) * costo_por_1000_tokens
costo_por_1000_tokens_respuesta = 0.0075
costo_respuesta = (500 / 1000) * costo_por_1000_tokens_respuesta
print(f"Costo total 1 consulta: ${costo_consulta + costo_respuesta:.4f}")
