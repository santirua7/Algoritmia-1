Algoritmo cuenta1
	Definir subtotal Como Entero
	Definir propina Como Real
	Definir personas Como Entero
	Definir total Como Entero
	Definir valorpro Como Real
	Definir pagoPersona Como Real
	Definir iva Como Real
	Escribir "escriba el valor de la cuenta "
	Leer subtotal
	propina <- 10
	Escribir "escriba la cantidad de personas"
	Leer personas
	valorpro <- subtotal*(propina/100)
	iva <- 19/100
	masiva <- subtotal*iva
	totalsin <-  masiva+subtotal
	total <- subtotal+masiva+valorpro
	pagoPersona <- total/personas
	pagosin <- subtotal+masiva
	pagoPersona2 <- pagosin/personas
	Escribir "La propina es: ", valorpro
	Escribir " la subcantidad mas el iva y la propina es: ", total
	escribir "la cantidad mas el iva pero sin la propina: ", totalsin
	Escribir "La cantidad a pagar mas iva y por persona *con propina* es: ", pagoPersona
	Escribir "La cantidad a pagar mas iva y por persona *sin propina* es: ", pagoPersona2
FinAlgoritmo
