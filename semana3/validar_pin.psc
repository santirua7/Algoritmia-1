Algoritmo ValidarPIN
	
    Definir pin, intentos Como Entero
    Definir acceso Como Logico
	
    intentos <- 0
    acceso <- Falso
	
    
    Mientras acceso = Falso Y intentos < 3 Hacer
		
        Escribir "Ingresa tu PIN:"
        Leer pin
		
        intentos <- intentos + 1
		
        Si pin = 2580 Entonces
            acceso <- Verdadero
        SiNo
            Escribir "PIN incorrecto"
            Escribir "Intentos restantes: ", 3 - intentos
        FinSi
		
    FinMientras
	
    Si acceso = Verdadero Entonces
        Escribir "Bienvenido"
    SiNo
        Escribir "Tarjeta bloqueada"
    FinSi
	
FinAlgoritmo
