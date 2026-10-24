Algoritmo Propinas
	Definir val_prop Como Real
	Definir cuenta Como Real
	Definir subtotal Como Real
	Definir total_c Como Real
	Definir porcentaje Como Real
	Definir personas Como Entero
	Definir cada1 Como Real
	Definir iva Como Real
	Escribir 'Cual es el valor de la cuenta?'
	Leer cuenta
	Escribir 'Cual es el porcentaje de propina'
	Leer porcentaje
	Escribir 'cuantas personas son: '
	Leer personas
	iva <- cuenta*(19/100)
	val_prop <- cuenta*(porcentaje/100)
	subtotal <- cuenta+val_prop
	total_c <- subtotal+iva
	cada1 <- total_c/personas
	Escribir 'El valor de la cuenta es: ', cuenta, ' mas la propina: ', subtotal, ' mas iva (19%): ', total_c, ' Cada persona debe pagar: ', cada1
FinAlgoritmo
