# Bitacora de pruebas: algoritmos en PSeInt

Este documento reúne, para cada algoritmo, la descripción, las tablas de decisión o de verdad, los casos de prueba (incluidos los casos borde).

| # | Algoritmo | Archivo |
| - | --------- | ------- |
| 1 | Año bisiesto | `bisiesto.psc` |
| 2 | Cobro de parqueadero | `parqueadero.psc` |
| 3 | Semáforo de inventario | `semaforo.psc` |
| 4 | Validación de edad | `validar_edad.psc` |
| 5 | Validación de registro | `validar_registro.psc` |

> **Cómo se calcularon los resultados.** La columna *Obtenido* sale de una réplica fiel de la lógica de cada `.psc` escrita en Python, porque no se pudo ejecutar PSeInt en este entorno. Antes de dar las pruebas por cerradas, ejecuta cada caso en PSeInt y confirma que la salida coincide.
>
> Los mensajes de salida se escriben **exactamente como los imprime el código** (por ejemplo, `Edad valida` sin tilde).

---

## 1. Año bisiesto (`bisiesto`)

Pide un año entero e indica si es bisiesto.

**Regla del código:** `(año % 4 = 0 y año % 100 <> 0) o año % 400 = 0`

Se define:

- **A:** `año % 4 = 0` (divisible entre 4)
- **B:** `año % 100 <> 0` (NO divisible entre 100)
- **C:** `año % 400 = 0` (divisible entre 400)

**Tabla de verdad** (resultado = `(A y B) o C`):

| A | B | C | A y B | (A y B) o C | Resultado | Ejemplo |
| :-: | :-: | :-: | :---: | :---------: | --------- | ------- |
| V | V | F | V | V | Es bisiesto | 2024 |
| V | F | V | F | V | Es bisiesto | 2000 |
| V | F | F | F | F | No es bisiesto | 1900 |
| F | V | F | F | F | No es bisiesto | 2023 |
| F | V | V | F | V | *Imposible* | – |
| F | F | V | F | V | *Imposible* | – |
| F | F | F | F | F | *Imposible* | – |
| V | V | V | V | V | *Imposible* | – |

Las filas marcadas como imposibles no pueden darse con números reales: si un año es divisible entre 100 también lo es entre 4, y si es divisible entre 400 lo es entre 100 (por lo tanto B es falso).

**Casos de prueba:**

| # | Año | año%4 | año%100 | año%400 | Esperado | Obtenido |
| - | --- | :---: | :-----: | :-----: | -------- | -------- |
| 1 | `2024` | 0 | 24 | 24 | Es bisiesto | Es bisiesto |
| 2 | `2023` | 3 | 23 | 23 | No es bisiesto | No es bisiesto |
| 3 | `1900` | 0 | 0 | 300 | No es bisiesto | No es bisiesto |
| 4 | `2000` | 0 | 0 | 0 | Es bisiesto | Es bisiesto |
| 5 | `2100` | 0 | 0 | 100 | No es bisiesto | No es bisiesto |
| 6 | `4` | 0 | 4 | 4 | Es bisiesto | Es bisiesto |
| 7 | `100` | 0 | 0 | 100 | No es bisiesto | No es bisiesto |
| 8 | `400` | 0 | 0 | 0 | Es bisiesto | Es bisiesto |
| 9 | `1` | 1 | 1 | 1 | No es bisiesto | No es bisiesto |

**Prueba de escritorio, caso 1 (año 2024):**

| Paso | año | año%4=0 | año%100<>0 | (A y B) | año%400=0 | Salida |
| ---- | --- | :-----: | :--------: | :-----: | :-------: | ------ |
| Lee dato | 2024 | | | | | |
| Evalúa A | 2024 | V | | | | |
| Evalúa B | 2024 | V | V | | | |
| Evalúa A y B | 2024 | V | V | V | | |
| Evalúa C | 2024 | V | V | V | no se necesita | |
| Decide | 2024 | V | V | V | | El año ingresado es bisiesto: 2024 |

**Prueba de escritorio, caso 3 (año 1900):**

| Paso | año | año%4=0 | año%100<>0 | (A y B) | año%400=0 | Salida |
| ---- | --- | :-----: | :--------: | :-----: | :-------: | ------ |
| Lee dato | 1900 | | | | | |
| Evalúa A | 1900 | V | | | | |
| Evalúa B | 1900 | V | F | | | |
| Evalúa A y B | 1900 | V | F | F | | |
| Evalúa C (1900 % 400 = 300) | 1900 | V | F | F | F | |
| Decide | 1900 | V | F | F | F | El año ingresado no es bisiesto: 1900 |

**Prueba de escritorio, caso 4 (año 2000):**

| Paso | año | año%4=0 | año%100<>0 | (A y B) | año%400=0 | Salida |
| ---- | --- | :-----: | :--------: | :-----: | :-------: | ------ |
| Lee dato | 2000 | | | | | |
| Evalúa A | 2000 | V | | | | |
| Evalúa B | 2000 | V | F | | | |
| Evalúa A y B | 2000 | V | F | F | | |
| Evalúa C (2000 % 400 = 0) | 2000 | V | F | F | V | |
| Decide | 2000 | V | F | F | V | El año ingresado es bisiesto: 2000 |

---

## 2. Cobro de parqueadero (`CobroParqueadero`)

Recibe el tipo de vehículo, los minutos de permanencia y si el usuario presenta factura de compra en el centro comercial.

**Tarifas y reglas:**

| Concepto | Valor |
| -------- | ----- |
| Tarifa por hora, carro | $4.000 |
| Tarifa por hora, moto | $2.000 |
| Tope máximo | $30.000 |
| Tiempo de gracia | Hasta 15 minutos (gratis) |
| Descuento con factura | 50% sobre el cobro ya topado |

Las horas se redondean hacia arriba con `Trunc((minutos + 59) / 60)`: cualquier fracción de hora cuenta como una hora completa. El tope se aplica antes del descuento por factura.

> **El código aplica el tope de $30.000 a carro Y a moto.** Si la regla de negocio dice que el tope es solo para el carro, el código necesita un ajuste (ver caso 14).

**Tabla de decisión:**

| Regla | Tipo | Minutos | Factura | Resultado |
| ----- | ---- | ------- | ------- | --------- |
| R1 | Cualquiera | Menos de 0 | Cualquiera | Error: minutos negativos |
| R2 | Distinto de carro o moto | 0 o más | Cualquiera | Error: tipo de vehiculo no valido |
| R3 | Carro o moto | De 0 a 15 | Cualquiera | Gratis ($0) |
| R4 | Carro o moto | Más de 15 | No | Horas × tarifa, máximo $30.000 |
| R5 | Carro o moto | Más de 15 | Sí | Lo mismo que R4, dividido entre 2 |

**Casos borde:**

| # | Tipo | Minutos | Factura | Horas | Esperado |
| - | ---- | ------- | ------- | ----- | -------- |
| 1 | Carro | 15 | No | – | $0 |
| 2 | Carro | 16 | No | 1 | $4.000 |
| 3 | Carro | 60 | No | 1 | $4.000 |
| 4 | Carro | 61 | No | 2 | $8.000 |
| 5 | Moto | 61 | Sí | 2 | $2.000 |
| 6 | Carro | 600 | No | 10 | $30.000 (tope) |
| 7 | Carro | 600 | Sí | 10 | $15.000 |
| 8 | Tipo "3" | 30 | No | – | Tipo no válido |
| 9 | Carro | -5 | No | – | Minutos negativos |
| 10 | Carro | 0 | No | – | $0 |
| 11 | Carro | 420 | No | 7 | $28.000 (justo bajo el tope) |
| 12 | Carro | 421 | No | 8 | $30.000 (32.000 se topa) |
| 13 | Moto | 900 | No | 15 | $30.000 (exacto, sin topar) |
| 14 | Moto | 901 | No | 16 | $30.000 (32.000 se topa) |

Los casos 1 a 9 salen de la especificación; los casos 10 a 14 se añadieron para probar los límites de 0 minutos y del tope.

**Prueba de escritorio, caso 4 (carro, 61 minutos, sin factura):**

| Paso | Tipo | Min | Fact | Tarifa | Horas | Valor |
| ---- | ---- | --- | ---- | ------ | ----- | ----- |
| Lee datos | carro | 61 | N | | | |
| ¿minutos < 0? No | carro | 61 | N | | | |
| ¿tipo válido? Sí | carro | 61 | N | | | |
| ¿minutos <= 15? No | carro | 61 | N | | | |
| Calcula horas: (61+59)/60 = 2 | carro | 61 | N | | 2 | |
| Según tipo | carro | 61 | N | 4000 | 2 | |
| Calcula valor: 2 × 4000 | carro | 61 | N | 4000 | 2 | 8000 |
| Aplica tope (8000 ≤ 30000) | carro | 61 | N | 4000 | 2 | 8000 |
| Aplica factura (no) | carro | 61 | N | 4000 | 2 | 8000 |
| **Salida** | | | | | | **Total a pagar: $8000** |

**Prueba de escritorio, caso 5 (moto, 61 minutos, con factura):**

| Paso | Tipo | Min | Fact | Tarifa | Horas | Valor |
| ---- | ---- | --- | ---- | ------ | ----- | ----- |
| Lee datos | moto | 61 | S | | | |
| ¿minutos < 0? No | moto | 61 | S | | | |
| ¿tipo válido? Sí | moto | 61 | S | | | |
| ¿minutos <= 15? No | moto | 61 | S | | | |
| Calcula horas: (61+59)/60 = 2 | moto | 61 | S | | 2 | |
| Según tipo | moto | 61 | S | 2000 | 2 | |
| Calcula valor: 2 × 2000 | moto | 61 | S | 2000 | 2 | 4000 |
| Aplica tope (4000 ≤ 30000) | moto | 61 | S | 2000 | 2 | 4000 |
| Aplica factura: 4000 / 2 | moto | 61 | S | 2000 | 2 | 2000 |
| **Salida** | | | | | | **Total a pagar: $2000** |

**Prueba de escritorio, caso 7 (carro, 600 minutos, con factura): aquí el tope sí cambia el valor**

| Paso | Tipo | Min | Fact | Tarifa | Horas | Valor |
| ---- | ---- | --- | ---- | ------ | ----- | ----- |
| Lee datos | carro | 600 | S | | | |
| ¿minutos < 0? No | carro | 600 | S | | | |
| ¿tipo válido? Sí | carro | 600 | S | | | |
| ¿minutos <= 15? No | carro | 600 | S | | | |
| Calcula horas: (600+59)/60 = 659/60 → Trunc = 10 | carro | 600 | S | | 10 | |
| Según tipo | carro | 600 | S | 4000 | 10 | |
| Calcula valor: 10 × 4000 | carro | 600 | S | 4000 | 10 | 40000 |
| Aplica tope (40000 > 30000) | carro | 600 | S | 4000 | 10 | 30000 |
| Aplica factura: 30000 / 2 | carro | 600 | S | 4000 | 10 | 15000 |
| **Salida** | | | | | | **Total a pagar: $15000** |

**Prueba de escritorio, caso 9 (carro, -5 minutos): termina en error**

| Paso | Tipo | Min | Fact | Tarifa | Horas | Valor |
| ---- | ---- | --- | ---- | ------ | ----- | ----- |
| Lee datos | carro | -5 | N | | | |
| ¿minutos < 0? Sí | carro | -5 | N | | | |
| **Salida** | | | | | | **Error: minutos negativos** |

### Notas del parqueadero

- **Mayúsculas y minúsculas (pendiente de verificar).** El código valida el tipo contra `"carro"` y `"moto"` (minúsculas), pero luego decide la tarifa con `tipo = "CARRO"` (mayúsculas). Si PSeInt distingue mayúsculas al comparar texto (no pude ejecutarlo para confirmarlo), el comportamiento sería este:

  | El usuario escribe | Comparación estricta | Comparación sin distinguir mayúsculas |
  | ------------------ | -------------------- | ------------------------------------- |
  | `carro` (61 min, sin factura) | Pasa la validación pero cobra tarifa de moto: **$4.000** | $8.000 |
  | `CARRO` o `Carro` | Error: tipo de vehiculo no valido | $8.000 |
  | `moto` | Funciona | Funciona |

  Algo parecido pasa con la factura: `factura = "S"` no convierte a mayúsculas, así que una `s` minúscula no daría descuento en comparación estricta.
- **División del descuento.** `total / 2` es una división real guardada en una variable entera. Con estas tarifas el total siempre es múltiplo de 2.000, así que la división es exacta y no hay problema.
- **Entrada.** El algoritmo pide el tipo como texto (`Carro` / `Moto`). Si tu documentación o tus logs muestran entrada numérica (`1` = carro, `2` = moto), verifica que el `.psc` y los logs usen el mismo formato.

---

## 3. Semáforo de inventario (`semaforo`)

Clasifica una cantidad de unidades según el nivel de existencias. La variable `unidades` está definida como **Real**, así que acepta decimales.

| Unidades | Mensaje que imprime el código |
| -------- | ----------------------------- |
| Menor que 0 | `Error` |
| 0 | `Rojo: agotado` |
| De 1 a 10 (inclusive) | `Amarillo: pedir` |
| Mayor que 10 | `Verde: Todo bien` |
| Entre 0 y 1 (sin incluirlos), por ejemplo 0.5 | **No imprime nada** |

**Casos de prueba:**

| # | Unidades | Esperado | Obtenido |
| - | :------: | -------- | -------- |
| 1 | `-1` | Error | Error |
| 2 | `0` | Rojo: agotado | Rojo: agotado |
| 3 | `1` | Amarillo: pedir | Amarillo: pedir |
| 4 | `10` | Amarillo: pedir | Amarillo: pedir |
| 5 | `11` | Verde: Todo bien | Verde: Todo bien |
| 6 | `50` | Verde: Todo bien | Verde: Todo bien |
| 7 | `10.5` | Verde: Todo bien | Verde: Todo bien |
| 8 | `0.5` | *(a definir)* | No imprime nada |

**Prueba de escritorio, caso 4 (unidades = 10, límite superior del amarillo):**

| Paso | unidades | ¿< 0? | ¿== 0? | ¿>= 1 y <= 10? | ¿> 10? | Salida |
| ---- | :------: | :---: | :----: | :------------: | :----: | ------ |
| Lee dato | 10 | | | | | |
| Evalúa `unidades < 0` | 10 | F | | | | |
| Evalúa `unidades == 0` | 10 | F | F | | | |
| Evalúa `unidades >= 1 y unidades <= 10` | 10 | F | F | V | | |
| Imprime | 10 | F | F | V | no se evalúa | Amarillo: pedir |

**Prueba de escritorio, caso 5 (unidades = 11, primer valor del verde):**

| Paso | unidades | ¿< 0? | ¿== 0? | ¿>= 1 y <= 10? | ¿> 10? | Salida |
| ---- | :------: | :---: | :----: | :------------: | :----: | ------ |
| Lee dato | 11 | | | | | |
| Evalúa `unidades < 0` | 11 | F | | | | |
| Evalúa `unidades == 0` | 11 | F | F | | | |
| Evalúa `unidades >= 1 y unidades <= 10` | 11 | F | F | F | | |
| Evalúa `unidades > 10` | 11 | F | F | F | V | |
| Imprime | 11 | F | F | F | V | Verde: Todo bien |

**Prueba de escritorio, caso 8 (unidades = 0.5): muestra el hueco del algoritmo**

| Paso | unidades | ¿< 0? | ¿== 0? | ¿>= 1 y <= 10? | ¿> 10? | Salida |
| ---- | :------: | :---: | :----: | :------------: | :----: | ------ |
| Lee dato | 0.5 | | | | | |
| Evalúa `unidades < 0` | 0.5 | F | | | | |
| Evalúa `unidades == 0` | 0.5 | F | F | | | |
| Evalúa `unidades >= 1 y unidades <= 10` | 0.5 | F | F | F | | |
| Evalúa `unidades > 10` | 0.5 | F | F | F | F | |
| Termina | 0.5 | F | F | F | F | *(nada)* |

### Notas del semáforo

- Como `unidades` es `Real`, un valor como `0.5` no cumple ninguna de las cuatro condiciones y el programa termina sin mostrar mensaje. Hay dos arreglos posibles: definir `unidades` como `Entero`, o cambiar la condición del amarillo a `unidades > 0 y unidades <= 10`.
- El código usa `==` para comparar. Verifica que tu perfil de PSeInt lo acepte (en el perfil flexible suele funcionar; si no, usa `=`).

---

## 4. Validación de edad (`ValidarEdad`)

Verifica que la edad esté en el rango de 0 a 120. El código **solo** responde si la edad es válida o inválida; no indica si la persona es mayor de edad.

**Regla del código:** `edad >= 0 Y edad <= 120` → `Edad valida`; en cualquier otro caso → `Edad invalida`.

**Tabla de verdad** (se usa la condición contraria, que describe cuándo es inválida):

| R1: Edad < 0 | R2: Edad > 120 | R1 ó R2 | Resultado |
| :----------: | :------------: | :-----: | --------- |
| V | V | V | Edad invalida (imposible en la práctica) |
| V | F | V | Edad invalida |
| F | V | V | Edad invalida |
| F | F | F | Edad valida |

La primera fila no puede ocurrir: ningún número es a la vez menor que 0 y mayor que 120.

**Tabla de verdad de la condición real del código:**

| `edad >= 0` | `edad <= 120` | Y | Resultado |
| :---------: | :-----------: | :-: | --------- |
| V | V | V | Edad valida |
| V | F | F | Edad invalida |
| F | V | F | Edad invalida |
| F | F | F | Imposible |

**Casos de prueba:**

| Edad | Esperado | Obtenido |
| :--: | -------- | -------- |
| `-1` | Edad invalida | Edad invalida |
| `0` | Edad valida | Edad valida |
| `1` | Edad valida | Edad valida |
| `50` | Edad valida | Edad valida |
| `120` | Edad valida | Edad valida |
| `121` | Edad invalida | Edad invalida |

**Prueba de escritorio, caso edad = 120 (límite superior válido):**

| Paso | edad | edad >= 0 | edad <= 120 | Y | Salida |
| ---- | :--: | :-------: | :---------: | :-: | ------ |
| Lee dato | 120 | | | | |
| Evalúa `edad >= 0` | 120 | V | | | |
| Evalúa `edad <= 120` | 120 | V | V | | |
| Evalúa `Y` | 120 | V | V | V | |
| Imprime | 120 | V | V | V | Edad valida |

**Prueba de escritorio, caso edad = 121 (primer valor inválido):**

| Paso | edad | edad >= 0 | edad <= 120 | Y | Salida |
| ---- | :--: | :-------: | :---------: | :-: | ------ |
| Lee dato | 121 | | | | |
| Evalúa `edad >= 0` | 121 | V | | | |
| Evalúa `edad <= 120` | 121 | V | F | | |
| Evalúa `Y` | 121 | V | F | F | |
| Imprime | 121 | V | F | F | Edad invalida |

**Prueba de escritorio, caso edad = -1 (primer valor inválido por debajo):**

| Paso | edad | edad >= 0 | edad <= 120 | Y | Salida |
| ---- | :--: | :-------: | :---------: | :-: | ------ |
| Lee dato | -1 | | | | |
| Evalúa `edad >= 0` | -1 | F | | | |
| Evalúa `edad <= 120` | -1 | F | V | | |
| Evalúa `Y` | -1 | F | V | F | |
| Imprime | -1 | F | V | F | Edad invalida |

---

## 5. Validación de registro (`Validar_Registro`)

Permite el registro solo si la edad es de 14 años o más **y** el usuario acepta los términos (`S`). La respuesta se convierte a mayúsculas con `Mayusculas()`, por lo que `s` y `S` son equivalentes.

**Regla del código:** `edad >= 14 y respuesta = "S"` → `Registro exitoso`; en cualquier otro caso → `No puedes registrarte`.

**Tabla de verdad:**

| Edad ≥ 14 | Acepta (S) | Resultado |
| :-------: | :--------: | --------- |
| V | V | Registro exitoso |
| V | F | No puedes registrarte |
| F | V | No puedes registrarte |
| F | F | No puedes registrarte |

**Casos de prueba:**

| Edad | Respuesta | Esperado | Obtenido |
| :--: | :-------: | -------- | -------- |
| `14` | S | Registro exitoso | Registro exitoso |
| `13` | S | No puedes registrarte | No puedes registrarte |
| `30` | n | No puedes registrarte | No puedes registrarte |
| `14` | s | Registro exitoso | Registro exitoso |
| `14` | N | No puedes registrarte | No puedes registrarte |
| `13` | n | No puedes registrarte | No puedes registrarte |

**Prueba de escritorio, caso 4 (edad 14, respuesta "s"):**

| Paso | edad | respuesta | edad >= 14 | respuesta = "S" | Salida |
| ---- | :--: | :-------: | :--------: | :-------------: | ------ |
| Lee edad | 14 | | | | |
| Lee respuesta | 14 | s | | | |
| `Mayusculas(respuesta)` | 14 | S | | | |
| Evalúa `edad >= 14` | 14 | S | V | | |
| Evalúa `respuesta = "S"` | 14 | S | V | V | |
| Imprime | 14 | S | V | V | Registro exitoso |

**Prueba de escritorio, caso 2 (edad 13, respuesta "S"):**

| Paso | edad | respuesta | edad >= 14 | respuesta = "S" | Salida |
| ---- | :--: | :-------: | :--------: | :-------------: | ------ |
| Lee edad | 13 | | | | |
| Lee respuesta | 13 | S | | | |
| `Mayusculas(respuesta)` | 13 | S | | | |
| Evalúa `edad >= 14` | 13 | S | F | | |
| Evalúa `respuesta = "S"` | 13 | S | F | V | |
| Imprime (F y V = F) | 13 | S | F | V | No puedes registrarte |

**Prueba de escritorio, caso 3 (edad 30, respuesta "n"):**

| Paso | edad | respuesta | edad >= 14 | respuesta = "S" | Salida |
| ---- | :--: | :-------: | :--------: | :-------------: | ------ |
| Lee edad | 30 | | | | |
| Lee respuesta | 30 | n | | | |
| `Mayusculas(respuesta)` | 30 | N | | | |
| Evalúa `edad >= 14` | 30 | N | V | | |
| Evalúa `respuesta = "S"` | 30 | N | V | F | |
| Imprime (V y F = F) | 30 | N | V | F | No puedes registrarte |

### Notas del registro

- El algoritmo no valida el rango de la edad: una edad de `200` o `-5` se procesa igual (`200` con `S` se registraría). Si lo necesitas, se puede combinar con la validación de edad del algoritmo 4.
- Los textos de salida de los logs de pruebas pueden diferir ligeramente de los del código (por ejemplo, `Cuantos años tienes?` frente a `¿Cuántos años tienes?`).
