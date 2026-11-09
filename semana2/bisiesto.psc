Algoritmo año_bisiesto
	
	Definir año Como Entero
	
	Escribir "Ingresa el año para saber si es bisiesto: "
	Leer año
	
	Si (año%4=0 y año%100<>0) o año%400=0 Entonces
		Escribir "El año es bisiesto: ", año
		
	SiNo
		Escribir "El año no es bisiesto: ", año
		
	FinSi
	
	
	
	
	
FinAlgoritmo
