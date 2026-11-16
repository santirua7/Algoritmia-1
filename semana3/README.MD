# Trazas de ejecución

Una **traza** (o prueba de escritorio) sigue el algoritmo instrucción por instrucción y anota cómo cambia cada variable y qué se muestra en pantalla. La columna *Línea* indica el número de línea del archivo `.psc`.

| # | Algoritmo | Archivo |
| - | --------- | ------- |
| 1 | Cajero de parqueadero | `cajeroparqueadero.psc` |
| 2 | Pirámide de asteriscos | `Piramide.psc` |

> Las trazas se calcularon con una réplica en Python de la lógica de cada `.psc`, porque no se pudo ejecutar PSeInt en este entorno. Confirma las salidas ejecutando los mismos datos en PSeInt.

---

## 1. Cajero de parqueadero (`CajeroParqueadero`)

Pide valores cobrados en un ciclo. Cada valor distinto de 0 se suma al `total` y cuenta un carro. Al ingresar `0` el ciclo termina y se muestran los carros atendidos y el total recaudado.

**Variables:**

| Variable | Tipo | Función |
| -------- | ---- | ------- |
| `valor` | Real | Valor que se acaba de leer |
| `total` | Real | Acumulador del dinero recaudado (inicia en 0) |
| `carros` | Entero | Contador de carros atendidos (inicia en 0) |

**Estructura:** `Repetir ... Hasta Que valor = 0` es un ciclo que se ejecuta **al menos una vez** y evalúa la condición al final. Por eso el `0` final se lee, se descarta en el `Si` y luego hace que el ciclo termine.

**Traza 1: entradas 4000, 8000, 30000, 0**

| Paso | Línea | Instrucción | valor | ¿valor <> 0? | total | carros | Salida |
| ---- | :---: | ----------- | :---: | :----------: | :---: | :----: | ------ |
| 1 | 6 | `total <- 0` | | | 0 | | |
| 2 | 7 | `carros <- 0` | | | 0 | 0 | |
| 3 | 11-12 | Pide y lee `valor` | 4000 | | 0 | 0 | Ingrese el valor cobrado (0 para terminar): |
| 4 | 14 | `Si valor <> 0` | 4000 | V | 0 | 0 | |
| 5 | 16 | `total <- total + valor` | 4000 | V | 4000 | 0 | |
| 6 | 17 | `carros <- carros + 1` | 4000 | V | 4000 | 1 | |
| 7 | 21 | `Hasta Que valor = 0` (4000 = 0 es F, repite) | 4000 | | 4000 | 1 | |
| 8 | 11-12 | Pide y lee `valor` | 8000 | | 4000 | 1 | Ingrese el valor cobrado (0 para terminar): |
| 9 | 14 | `Si valor <> 0` | 8000 | V | 4000 | 1 | |
| 10 | 16 | `total <- total + valor` | 8000 | V | 12000 | 1 | |
| 11 | 17 | `carros <- carros + 1` | 8000 | V | 12000 | 2 | |
| 12 | 21 | `Hasta Que valor = 0` (8000 = 0 es F, repite) | 8000 | | 12000 | 2 | |
| 13 | 11-12 | Pide y lee `valor` | 30000 | | 12000 | 2 | Ingrese el valor cobrado (0 para terminar): |
| 14 | 14 | `Si valor <> 0` | 30000 | V | 12000 | 2 | |
| 15 | 16 | `total <- total + valor` | 30000 | V | 42000 | 2 | |
| 16 | 17 | `carros <- carros + 1` | 30000 | V | 42000 | 3 | |
| 17 | 21 | `Hasta Que valor = 0` (30000 = 0 es F, repite) | 30000 | | 42000 | 3 | |
| 18 | 11-12 | Pide y lee `valor` | 0 | | 42000 | 3 | Ingrese el valor cobrado (0 para terminar): |
| 19 | 14 | `Si valor <> 0` | 0 | F | 42000 | 3 | |
| 20 | 21 | `Hasta Que valor = 0` (0 = 0 es V, sale del ciclo) | 0 | | 42000 | 3 | |
| 21 | 23 | `Escribir "Carros atendidos: ", carros` | 0 | | 42000 | 3 | Carros atendidos: 3 |
| 22 | 24 | `Escribir "Total recaudado: $", total` | 0 | | 42000 | 3 | Total recaudado: $42000 |

Resultado: 3 carros y $42000 recaudados.

**Traza 2: el usuario ingresa 0 de inmediato**

El ciclo `Repetir` se ejecuta una vez aunque el primer valor sea 0, porque la condición se revisa al final.

| Paso | Línea | Instrucción | valor | ¿valor <> 0? | total | carros | Salida |
| ---- | :---: | ----------- | :---: | :----------: | :---: | :----: | ------ |
| 1 | 6 | `total <- 0` | | | 0 | | |
| 2 | 7 | `carros <- 0` | | | 0 | 0 | |
| 3 | 11-12 | Pide y lee `valor` | 0 | | 0 | 0 | Ingrese el valor cobrado (0 para terminar): |
| 4 | 14 | `Si valor <> 0` | 0 | F | 0 | 0 | |
| 5 | 21 | `Hasta Que valor = 0` (0 = 0 es V, sale del ciclo) | 0 | | 0 | 0 | |
| 6 | 23 | `Escribir "Carros atendidos: ", carros` | 0 | | 0 | 0 | Carros atendidos: 0 |
| 7 | 24 | `Escribir "Total recaudado: $", total` | 0 | | 0 | 0 | Total recaudado: $0 |

Resultado: 0 carros y $0 recaudados.

**Traza 3: valor decimal y valor negativo (2500.5, -1000, 0)**

El algoritmo no valida el valor: acepta decimales (la variable es Real) y también acepta números negativos, que se suman al total y cuentan como un carro más.

| Paso | Línea | Instrucción | valor | ¿valor <> 0? | total | carros | Salida |
| ---- | :---: | ----------- | :---: | :----------: | :---: | :----: | ------ |
| 1 | 6 | `total <- 0` | | | 0 | | |
| 2 | 7 | `carros <- 0` | | | 0 | 0 | |
| 3 | 11-12 | Pide y lee `valor` | 2500.5 | | 0 | 0 | Ingrese el valor cobrado (0 para terminar): |
| 4 | 14 | `Si valor <> 0` | 2500.5 | V | 0 | 0 | |
| 5 | 16 | `total <- total + valor` | 2500.5 | V | 2500.5 | 0 | |
| 6 | 17 | `carros <- carros + 1` | 2500.5 | V | 2500.5 | 1 | |
| 7 | 21 | `Hasta Que valor = 0` (2500.5 = 0 es F, repite) | 2500.5 | | 2500.5 | 1 | |
| 8 | 11-12 | Pide y lee `valor` | -1000 | | 2500.5 | 1 | Ingrese el valor cobrado (0 para terminar): |
| 9 | 14 | `Si valor <> 0` | -1000 | V | 2500.5 | 1 | |
| 10 | 16 | `total <- total + valor` | -1000 | V | 1500.5 | 1 | |
| 11 | 17 | `carros <- carros + 1` | -1000 | V | 1500.5 | 2 | |
| 12 | 21 | `Hasta Que valor = 0` (-1000 = 0 es F, repite) | -1000 | | 1500.5 | 2 | |
| 13 | 11-12 | Pide y lee `valor` | 0 | | 1500.5 | 2 | Ingrese el valor cobrado (0 para terminar): |
| 14 | 14 | `Si valor <> 0` | 0 | F | 1500.5 | 2 | |
| 15 | 21 | `Hasta Que valor = 0` (0 = 0 es V, sale del ciclo) | 0 | | 1500.5 | 2 | |
| 16 | 23 | `Escribir "Carros atendidos: ", carros` | 0 | | 1500.5 | 2 | Carros atendidos: 2 |
| 17 | 24 | `Escribir "Total recaudado: $", total` | 0 | | 1500.5 | 2 | Total recaudado: $1500.5 |

Resultado: 2 carros y $1500.5. El valor negativo reduce el total y aun así suma un carro. Si esto no es deseable, habría que agregar una validación (`valor < 0`).

**Resumen de casos del cajero:**

| # | Entradas | Carros esperados | Total esperado |
| - | -------- | :--------------: | :------------: |
| 1 | 4000, 8000, 30000, 0 | 3 | $42000 |
| 2 | 0 | 0 | $0 |
| 3 | 2500.5, -1000, 0 | 2 | $1500.5 |

---

## 2. Pirámide (`Piramide`)

Dibuja una pirámide de asteriscos de `n` filas de alto. Usa un ciclo `Para` externo (una vuelta por fila) y dos ciclos `Para` internos: uno que escribe los espacios de la izquierda y otro que escribe los asteriscos.

**Fórmulas por fila:**

| Elemento | Cantidad en la fila `fila` |
| -------- | -------------------------- |
| Espacios a la izquierda | `n - fila` |
| Asteriscos | `2 * fila - 1` |

`Escribir Sin Saltar` deja el cursor en la misma línea; `Escribir ""` al final de cada fila produce el salto de línea.

**Valores por fila para n = 4:**

| fila | Espacios (`n - fila`) | Asteriscos (`2 * fila - 1`) | Línea resultante (· = espacio) |
| :--: | :-------------------: | :-------------------------: | ------------------------------ |
| 1 | 3 | 1 | `···*` |
| 2 | 2 | 3 | `··***` |
| 3 | 1 | 5 | `·*****` |
| 4 | 0 | 7 | `*******` |

**Traza 1: n = 4**

| Paso | Línea | Instrucción | n | fila | j | Condición | Línea en pantalla (· = espacio) |
| ---- | :---: | ----------- | :-: | :--: | :-: | :-------: | ------------------------------- |
| 1 | 5 | `Leer n` | 4 | | | | |
| 2 | 7 | `Para fila <- 1 Hasta n` | 4 | 1 |  | 1 <= 4: V |  |
| 3 | 9 | `Para j <- 1 Hasta n - fila` (hasta 3) | 4 | 1 | 1 | 1 <= 3: V |  |
| 4 | 10 | `Escribir Sin Saltar " "` | 4 | 1 | 1 |  | · |
| 5 | 9 | `Para j <- 1 Hasta n - fila` (hasta 3) | 4 | 1 | 2 | 2 <= 3: V | · |
| 6 | 10 | `Escribir Sin Saltar " "` | 4 | 1 | 2 |  | ·· |
| 7 | 9 | `Para j <- 1 Hasta n - fila` (hasta 3) | 4 | 1 | 3 | 3 <= 3: V | ·· |
| 8 | 10 | `Escribir Sin Saltar " "` | 4 | 1 | 3 |  | ··· |
| 9 | 9 | `Para j <- 1 Hasta n - fila` (hasta 3) | 4 | 1 | 4 | 4 <= 3: F, sale | ··· |
| 10 | 13 | `Para j <- 1 Hasta 2 * fila - 1` (hasta 1) | 4 | 1 | 1 | 1 <= 1: V | ··· |
| 11 | 14 | `Escribir Sin Saltar "*"` | 4 | 1 | 1 |  | ···* |
| 12 | 13 | `Para j <- 1 Hasta 2 * fila - 1` (hasta 1) | 4 | 1 | 2 | 2 <= 1: F, sale | ···* |
| 13 | 17 | `Escribir ""` (salto de línea) | 4 | 1 |  |  | ···* ⏎ |
| 14 | 7 | `Para fila <- 2 Hasta n` | 4 | 2 |  | 2 <= 4: V |  |
| 15 | 9 | `Para j <- 1 Hasta n - fila` (hasta 2) | 4 | 2 | 1 | 1 <= 2: V |  |
| 16 | 10 | `Escribir Sin Saltar " "` | 4 | 2 | 1 |  | · |
| 17 | 9 | `Para j <- 1 Hasta n - fila` (hasta 2) | 4 | 2 | 2 | 2 <= 2: V | · |
| 18 | 10 | `Escribir Sin Saltar " "` | 4 | 2 | 2 |  | ·· |
| 19 | 9 | `Para j <- 1 Hasta n - fila` (hasta 2) | 4 | 2 | 3 | 3 <= 2: F, sale | ·· |
| 20 | 13 | `Para j <- 1 Hasta 2 * fila - 1` (hasta 3) | 4 | 2 | 1 | 1 <= 3: V | ·· |
| 21 | 14 | `Escribir Sin Saltar "*"` | 4 | 2 | 1 |  | ··* |
| 22 | 13 | `Para j <- 1 Hasta 2 * fila - 1` (hasta 3) | 4 | 2 | 2 | 2 <= 3: V | ··* |
| 23 | 14 | `Escribir Sin Saltar "*"` | 4 | 2 | 2 |  | ··** |
| 24 | 13 | `Para j <- 1 Hasta 2 * fila - 1` (hasta 3) | 4 | 2 | 3 | 3 <= 3: V | ··** |
| 25 | 14 | `Escribir Sin Saltar "*"` | 4 | 2 | 3 |  | ··*** |
| 26 | 13 | `Para j <- 1 Hasta 2 * fila - 1` (hasta 3) | 4 | 2 | 4 | 4 <= 3: F, sale | ··*** |
| 27 | 17 | `Escribir ""` (salto de línea) | 4 | 2 |  |  | ··*** ⏎ |
| 28 | 7 | `Para fila <- 3 Hasta n` | 4 | 3 |  | 3 <= 4: V |  |
| 29 | 9 | `Para j <- 1 Hasta n - fila` (hasta 1) | 4 | 3 | 1 | 1 <= 1: V |  |
| 30 | 10 | `Escribir Sin Saltar " "` | 4 | 3 | 1 |  | · |
| 31 | 9 | `Para j <- 1 Hasta n - fila` (hasta 1) | 4 | 3 | 2 | 2 <= 1: F, sale | · |
| 32 | 13 | `Para j <- 1 Hasta 2 * fila - 1` (hasta 5) | 4 | 3 | 1 | 1 <= 5: V | · |
| 33 | 14 | `Escribir Sin Saltar "*"` | 4 | 3 | 1 |  | ·* |
| 34 | 13 | `Para j <- 1 Hasta 2 * fila - 1` (hasta 5) | 4 | 3 | 2 | 2 <= 5: V | ·* |
| 35 | 14 | `Escribir Sin Saltar "*"` | 4 | 3 | 2 |  | ·** |
| 36 | 13 | `Para j <- 1 Hasta 2 * fila - 1` (hasta 5) | 4 | 3 | 3 | 3 <= 5: V | ·** |
| 37 | 14 | `Escribir Sin Saltar "*"` | 4 | 3 | 3 |  | ·*** |
| 38 | 13 | `Para j <- 1 Hasta 2 * fila - 1` (hasta 5) | 4 | 3 | 4 | 4 <= 5: V | ·*** |
| 39 | 14 | `Escribir Sin Saltar "*"` | 4 | 3 | 4 |  | ·**** |
| 40 | 13 | `Para j <- 1 Hasta 2 * fila - 1` (hasta 5) | 4 | 3 | 5 | 5 <= 5: V | ·**** |
| 41 | 14 | `Escribir Sin Saltar "*"` | 4 | 3 | 5 |  | ·***** |
| 42 | 13 | `Para j <- 1 Hasta 2 * fila - 1` (hasta 5) | 4 | 3 | 6 | 6 <= 5: F, sale | ·***** |
| 43 | 17 | `Escribir ""` (salto de línea) | 4 | 3 |  |  | ·***** ⏎ |
| 44 | 7 | `Para fila <- 4 Hasta n` | 4 | 4 |  | 4 <= 4: V |  |
| 45 | 9 | `Para j <- 1 Hasta n - fila` (hasta 0) | 4 | 4 | 1 | 1 <= 0: F, sale |  |
| 46 | 13 | `Para j <- 1 Hasta 2 * fila - 1` (hasta 7) | 4 | 4 | 1 | 1 <= 7: V |  |
| 47 | 14 | `Escribir Sin Saltar "*"` | 4 | 4 | 1 |  | * |
| 48 | 13 | `Para j <- 1 Hasta 2 * fila - 1` (hasta 7) | 4 | 4 | 2 | 2 <= 7: V | * |
| 49 | 14 | `Escribir Sin Saltar "*"` | 4 | 4 | 2 |  | ** |
| 50 | 13 | `Para j <- 1 Hasta 2 * fila - 1` (hasta 7) | 4 | 4 | 3 | 3 <= 7: V | ** |
| 51 | 14 | `Escribir Sin Saltar "*"` | 4 | 4 | 3 |  | *** |
| 52 | 13 | `Para j <- 1 Hasta 2 * fila - 1` (hasta 7) | 4 | 4 | 4 | 4 <= 7: V | *** |
| 53 | 14 | `Escribir Sin Saltar "*"` | 4 | 4 | 4 |  | **** |
| 54 | 13 | `Para j <- 1 Hasta 2 * fila - 1` (hasta 7) | 4 | 4 | 5 | 5 <= 7: V | **** |
| 55 | 14 | `Escribir Sin Saltar "*"` | 4 | 4 | 5 |  | ***** |
| 56 | 13 | `Para j <- 1 Hasta 2 * fila - 1` (hasta 7) | 4 | 4 | 6 | 6 <= 7: V | ***** |
| 57 | 14 | `Escribir Sin Saltar "*"` | 4 | 4 | 6 |  | ****** |
| 58 | 13 | `Para j <- 1 Hasta 2 * fila - 1` (hasta 7) | 4 | 4 | 7 | 7 <= 7: V | ****** |
| 59 | 14 | `Escribir Sin Saltar "*"` | 4 | 4 | 7 |  | ******* |
| 60 | 13 | `Para j <- 1 Hasta 2 * fila - 1` (hasta 7) | 4 | 4 | 8 | 8 <= 7: F, sale | ******* |
| 61 | 17 | `Escribir ""` (salto de línea) | 4 | 4 |  |  | ******* ⏎ |
| 62 | 7 | `Para fila` (fila = 5) | 4 | 5 |  | 5 <= 4: F, termina |  |

Salida final en pantalla (los espacios son reales):

```
   *
  ***
 *****
*******
```

**Traza 2: n = 1 (caso mínimo)**

Con n = 1 el ciclo de espacios no se ejecuta ninguna vez porque `n - fila = 0` y la condición `1 <= 0` es falsa desde el inicio.

| Paso | Línea | Instrucción | n | fila | j | Condición | Línea en pantalla (· = espacio) |
| ---- | :---: | ----------- | :-: | :--: | :-: | :-------: | ------------------------------- |
| 1 | 5 | `Leer n` | 1 | | | | |
| 2 | 7 | `Para fila <- 1 Hasta n` | 1 | 1 |  | 1 <= 1: V |  |
| 3 | 9 | `Para j <- 1 Hasta n - fila` (hasta 0) | 1 | 1 | 1 | 1 <= 0: F, sale |  |
| 4 | 13 | `Para j <- 1 Hasta 2 * fila - 1` (hasta 1) | 1 | 1 | 1 | 1 <= 1: V |  |
| 5 | 14 | `Escribir Sin Saltar "*"` | 1 | 1 | 1 |  | * |
| 6 | 13 | `Para j <- 1 Hasta 2 * fila - 1` (hasta 1) | 1 | 1 | 2 | 2 <= 1: F, sale | * |
| 7 | 17 | `Escribir ""` (salto de línea) | 1 | 1 |  |  | * ⏎ |
| 8 | 7 | `Para fila` (fila = 2) | 1 | 2 |  | 2 <= 1: F, termina |  |

Salida final: una sola línea con un asterisco.

```
*
```

**Traza 3: n = 0 (no dibuja nada)**

La condición `1 <= 0` es falsa, así que el ciclo externo nunca se ejecuta.

| Paso | Línea | Instrucción | n | fila | j | Condición | Línea en pantalla (· = espacio) |
| ---- | :---: | ----------- | :-: | :--: | :-: | :-------: | ------------------------------- |
| 1 | 5 | `Leer n` | 0 | | | | |
| 2 | 7 | `Para fila` (fila = 1) | 0 | 1 |  | 1 <= 0: F, termina |  |

Salida final: no se imprime ninguna fila.

**Resumen de casos de la pirámide:**

| # | n | Filas dibujadas | Última línea (ancho) |
| - | :-: | :-------------: | :------------------: |
| 1 | 4 | 4 | 7 asteriscos |
| 2 | 1 | 1 | 1 asterisco |
| 3 | 0 | 0 | no dibuja nada |

### Notas de la pirámide

- El algoritmo no valida `n`: con un valor negativo tampoco dibuja nada, igual que con 0.
- La última fila siempre tiene `2 * n - 1` asteriscos y ninguna cantidad de espacios.
