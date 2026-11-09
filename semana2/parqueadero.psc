
Algoritmo CobroParqueadero
	
    Definir tipo Como Caracter
    Definir factura Como Caracter
    Definir minutos Como Entero
    Definir horas Como Entero
    Definir tarifa Como Entero
    Definir total Como Entero
	
    Escribir "===== PARQUEADERO ====="
	
    Escribir "Ingrese el tipo de vehiculo (Carro/Moto):"
    Leer tipo
	
    Escribir "Ingrese los minutos estacionados:"
    Leer minutos
	
    Escribir "Tiene factura del centro comercial? (S/N):"
    Leer factura
	
   
    Si minutos < 0 Entonces
		
        Escribir "Error: minutos negativos"
		
    SiNo
		
        
        Si tipo <> "carro" Y tipo <> "moto" Entonces
			
            Escribir "Error: tipo de vehiculo no valido"
			
        SiNo
			
            Si minutos <= 15 Entonces
				
                total <- 0
				
            SiNo
				
			    horas <- Trunc((minutos + 59) / 60)
				
                
                Si tipo = "CARRO" Entonces
                    tarifa <- 4000
                SiNo
                    tarifa <- 2000
                FinSi
				
                total <- horas * tarifa
				
                Si total > 30000 Entonces
                    total <- 30000
                FinSi
				
                
                Si factura = "S" Entonces
                    total <- total / 2
                FinSi
				
            FinSi
			
            Escribir "========================"
            Escribir "Tipo de vehiculo: ", tipo
            Escribir "Minutos estacionados: ", minutos
            Escribir "Total a pagar: $", total
            Escribir "========================"
			
        FinSi
		
    FinSi
	
FinAlgoritmo
