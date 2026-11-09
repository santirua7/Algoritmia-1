Algoritmo NotasEstudiantes
	
    Definir nota, suma, promedio Como Real
    Definir i, aprobados Como Entero
    Definir mayor, menor Como Real
    Definir perdio Como Logico
	
    
    suma <- 0
    aprobados <- 0
    perdio <- Falso
	
    Para i <- 1 Hasta 5 Hacer
		
        Escribir "Ingrese la nota del estudiante ", i, ":"
        Leer nota
		
        
        suma <- suma + nota
		
        
        Si i = 1 Entonces
            mayor <- nota
            menor <- nota
        SiNo
			
            
            Si nota > mayor Entonces
                mayor <- nota
            FinSi
			
            
            Si nota < menor Entonces
                menor <- nota
            FinSi
			
        FinSi
		
        
        Si nota >= 3 Entonces
            aprobados <- aprobados + 1
        SiNo
			
            
            perdio <- Verdadero
			
        FinSi
		
    FinPara
	
    
    promedio <- suma / 5
	
    
    Escribir "PROMEDIO: ", promedio
    Escribir "ESTUDIANTES APROBADOS: ", aprobados
    Escribir "NOTA MAS ALTA: ", mayor
    Escribir "NOTA MAS BAJA: ", menor
	
    Si perdio = Verdadero Entonces
        Escribir "Alguien perdio la materia"
    SiNo
        Escribir "Todos aprobaron la materia"
    FinSi
	
    Escribir "=========================="
	
FinAlgoritmo
