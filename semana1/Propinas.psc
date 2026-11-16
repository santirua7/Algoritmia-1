Algoritmo ceunta
	Definir cuenta Como Entero
	Definir propina Como Real
	Definir personas Como Entero
	Definir total Como Entero
	Definir valorpro Como Real
	Definir pagoPersona Como Real
	Escribir "escriba el total de la cuenta "
	Leer cuenta
	Escribir "escriba el porcentaje (%) de la propina"
	Leer propina
	Escribir "escriba la cantidad de personas"
	Leer personas
	valorpro <- cuenta*(propina/100)
	total <- cuenta+valorpro
	pagoPersona <- total/personas
	Escribir "La propina es: ", valorpro
	Escribir "La cantidad total a pagar es: ", total
	Escribir "La cantidad a pagar por persona es: ", pagoPersona
FinAlgoritmo
