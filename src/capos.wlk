//CORRECCION: Nota: Bien+. quedó un poco desprolijo la integración entre lo que ya tenían con wollokGame, haciendo que haya
//dos caminos dsintos por los cuales las cosas tienen efecto sobre un heroes (llamando al metodo efecto o al llego). Unificar en 
//un único mensaje.

//Para a próxima entrega, que ya saben herencia, Hagan una clase padre Artefacto que tenga el código que quedó duplicado en los 
//artefactos.


class Capo {

	// si le pongo null a la variable "bando" no funcionan los test porque no reconoce la referencia del mismo
	//CORRECCION: Yo lo probé con null y no me tiró ningun problema. Lo que te pudo haber pasado
	//CORRECCION: Es que estabas usando el bando antes de inicializarlo con un valor correcto. Ya no pasa. Cambiarlo
	var property bando = 1
	var property luchaBase = null
	var property hechiceriaBase = null
	var property artefactos = []
	var puntoDeVida
	var property posicion = game.at(2, 3)
	var property imagen = null

	method artefactos() = artefactos

	method obtenerArtefacto(_artefacto) {
		artefactos.add(_artefacto)
	}

	method valorHechiceria() = hechiceriaBase + artefactos.sum({ artefacto => artefacto.puntosHechiceria(self) })

	method valorLucha() = luchaBase + artefactos.sum({ artefacto => artefacto.puntosLucha(self) })

	method incrementarLucha() {
		luchaBase += 1
	}

	method incrementarHechiceria() {
		hechiceriaBase += 1
	}

	method darArtefactos(capo) {
		capo.artefactos().addAll(self.artefactos())
		self.artefactos([])
	}

	method sumaDeValores(capo) {
		return capo.valorHechiceria() + capo.valorLucha()
	}

	method peleaDeCapos(capo) {
		//CORRECCION: acá deberías enviar el mensaje sin parámetros: self.sumaDeValores() >= capo.sumaDeValores()
		//CORRECCION: No es correcto que el valor del otro capo lo calcule self. Vos no podés asumir de que clase es, podría tener un algoritmo
		//CORRECCION: distinto
		if (self.sumaDeValores(self) >= self.sumaDeValores(capo)) {
			capo.matarCapo()
			
			game.removeVisual(capo)
		} //CORRECCION: faltan llaves en el self, asi como está siempre se remueve self, gane o pierda, quedó fuera del if 
		else self.matarCapo()
		game.removeVisual(self)
	}

	method estaVivo() {
		//CORRECCION: solo se necesita saber si está vivo o muerto, usar booleanos
		return puntoDeVida == 1
	}

	method matarCapo() {
		//CORRECCION: solo se necesita saber si está vivo o muerto, usar booleanos
		puntoDeVida = 0
	}

	method encontrarCapo(capo) {
		if (capo.bando() == bando) self.darArtefactos(capo) else self.peleaDeCapos(capo)
	}


//CORRECCION Acá hay una duplicidad de responsabilidad. El mensaje llego(capo) y encontrarAlgo deberían ser el mismo, porque significa 
//CORRECCION lo mismo. Uno está desde el punto de vista del parámetro y otro de self. Debería quedar uno solo.


	method encontrarAlgo(algo) {
		algo.efecto(self)
	}


	method efecto(capo) {
		capo.encontrarCapo(self)
	}

	method llego(capo) {
		self.encontrarCapo(capo)
	}

}

class Neblina {

	var property posicion = game.at(6, 6)
	var property imagen = "niebla.png"
	var property cosasOcultas = []

	method efecto(capo) {
		//COREECCION: en lugar de mandar el mensaje encontrarAlgo, debería ser "cosaOculta.llego(capo)"
		cosasOcultas.forEach({ cosaOculta => capo.encontrarAlgo(cosaOculta)})
		game.removeVisual(self)
	}

	//CORRECCION, no aporta ningún valor la existencia de un método separado para el efecto
	//CORRECCION, es necesario porque tienen esa ducplicacidad entre efecto y llego (del game usan llego, pero de otros
	//CORRECCION objetos usan efecto. Unificar!
	method llego(capo) {
		self.efecto(capo)
	}

}

object espadaDelDestino {

	var imagen = "espadaDelDestino.png"

	method puntosLucha(capo) = 3

	method puntosHechiceria(capo) = 0

	method efecto(capo) {
		capo.obtenerArtefacto(self)
	}

	method llego(capo) {
		self.efecto(capo)
		game.removeVisual(self)
	}

}	

object libroDeHechizos {

	var imagen = "libroDeHechizos.png"

	method puntosLucha(capo) = 0

	method puntosHechiceria(capo) = capo.hechiceriaBase()

	method efecto(capo) {
		capo.obtenerArtefacto(self)
	}

	method llego(capo) {
		self.efecto(capo)
		game.removeVisual(self)
	}

}

object collarDivino {

	var imagen = "collarDivino.png"

	method puntosLucha(capo) = 1

	method puntosHechiceria(capo) = 1

	method efecto(capo) {
		capo.obtenerArtefacto(self)
	}

	method llego(capo) {
		self.efecto(capo)
		game.removeVisual(self)
	}

}

//parte 2 
class Armadura {

	var property refuerzo = noRefuerzo
	var luchaBase = 2
	var hechiceriaBase = 0
	var imagen = "armadura.png"

	method puntosLucha(capo) = luchaBase + refuerzo.puntosLucha(capo)

	method puntosHechiceria(capo) = hechiceriaBase + refuerzo.puntosHechiceria(capo)

	method efecto(capo) {
		capo.obtenerArtefacto(self)
	}

	method llego(capo) {
		self.efecto(capo)
		game.removeVisual(self)
	}

}

object cotaDeMalla {

	method puntosLucha(capo) = 1

	method puntosHechiceria(capo) = 0

	method efecto(capo) {
	}

}

object bendicion {

	method puntosLucha(capo) = 0

	method puntosHechiceria(capo) = 1

	method efecto(capo) {
	}

}

object hechizo {

	method puntosLucha(capo) = 0

	method puntosHechiceria(capo) = if (capo.hechiceriaBase() > 3) 2 else 0

	method efecto(capo) {
	}

}

object noRefuerzo {

	method puntosLucha(capo) = 0

	method puntosHechiceria(capo) = 0

}

object espejoFantastico {

	var imagen = "espejoFantastico.png"

	method puntosLucha(capo) {
		if (not (self.artefactosSinEspejoFantastico(capo).isEmpty())) {
			return self.mejorArtefacto(capo).puntosLucha(capo)
		} else {
			return 0
		}
	}

	method puntosHechiceria(capo) {
		if (not (self.artefactosSinEspejoFantastico(capo).isEmpty())) {
			return self.mejorArtefacto(capo).puntosHechiceria(capo)
		} else {
			return 0
		}
	}

	method efecto(capo) {
		capo.obtenerArtefacto(self)
	}

	method llego(capo) {
		self.efecto(capo)
		game.removeVisual(self)
	}

	method artefactosSinEspejoFantastico(capo) = capo.artefactos().filter({ artefacto => artefacto != self })

	method mejorArtefacto(capo) = self.artefactosSinEspejoFantastico(capo).max({ artefacto => artefacto.puntosLucha(capo) + artefacto.puntosHechiceria(capo) })

}

//parte3
class Bando {

	var property tesoro = 0
	var property reservaDeMateriales = 0

	method incrementarTesoro(valor) {
		tesoro += valor
	}

	method incrementarReservaDeMateriales(valor) {
		reservaDeMateriales += valor
	}

	method llego(capo) {
	}

}

class CofrecitoDeOro {

    //CORRECCION: El enunciado sugiere usar 100 como valor por defecto
	var property valor = 0
	var imagen = "cofre.png"

	method efecto(capo) {
		//CORRECCION: es preferible no encadernar estos mensajes: enviar el mensaje incrementarTesoro al capo, y que el capo hable con su bando
		//CORRECCION: En este caso sencillo no se ve mucho la mejora, pero la solucion que les propongo es mas flexible
		//CORRECCION: Permitiría la existencia de capos que tienen varios bandos, por ejemplo.
		capo.bando().incrementarTesoro(valor)
	}

	method llego(capo) {
		self.efecto(capo)
		game.removeVisual(self)
	}

}

class CumuloDeCarbon {

	const property valor = 50
	var imagen = "carbon.png"

	method efecto(capo) {
		capo.bando().incrementarReservaDeMateriales(valor)
	}

	method llego(capo) {
		self.efecto(capo)
		game.removeVisual(self)
	}

}

class ViejoSabio {

//CORRECCION: Esta variable no se usa, eliminar
	var lucha = ayudanteDeSabio
	var hechiceria = 1
	var imagen = "viejoSabio.png"

	method efecto(capo) {
		capo.luchaBase(self.valorQueDaElViejoSabioDeLucha(capo))
		capo.hechiceriaBase(self.valorQueDaElViejoSabioDeHechiceria(capo))
	}

	method valorQueDaElViejoSabioDeLucha(capo) {
		return capo.luchaBase() + ayudanteDeSabio.lucha()
	}

	method valorQueDaElViejoSabioDeHechiceria(capo) {
		return capo.hechiceriaBase() + hechiceria
	}

	method llego(capo) {
		self.efecto(capo)
		game.removeVisual(self)
	}

}

object ayudanteDeSabio {

	var property lucha = 1

}