Algoritmo CajeroParqueadero
	
    Definir valor, total Como Real
    Definir carros Como Entero
	
    total <- 0
    carros <- 0
	
    Repetir
		
        Escribir "Ingrese el valor cobrado (0 para terminar):"
        Leer valor
		
        Si valor <> 0 Entonces
			
            total <- total + valor
            carros <- carros + 1
			
        FinSi
		
    Hasta Que valor = 0
	
    Escribir "Carros atendidos: ", carros
    Escribir "Total recaudado: $", total
   
	
FinAlgoritmo
