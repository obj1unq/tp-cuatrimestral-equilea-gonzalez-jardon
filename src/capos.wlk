class Capo {

	// si le pongo null a la variable "bando" no funcionan los test porque no reconoce la referencia del mismo
	var property bando = 1
	var property luchaBase = null
	var property hechiceriaBase = null
	var property artefactos = []
	var puntoDeVida
	

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
		artefactos.addAll(capo.artefactos())
		capo.artefactos([])
	}

	method sumaDeValores(capo) {
		return capo.valorHechiceria() + capo.valorLucha()
	}

	method peleaDeCapos(capo) {
		if (self.sumaDeValores(capo) > self.sumaDeValores(self)) {
			self.matarCapo()
		} else capo.matarCapo()
	}

	method estaVivo() {
		return puntoDeVida == 1
	}

	method matarCapo() {
		puntoDeVida = 0
	}

	method encontrarCapo(capo) {
		if (capo.bando() == bando) self.darArtefactos(capo) else self.peleaDeCapos(capo)
	}

	method encontrarAlgo(algo) {
		algo.efecto(self)
	}
	
	method efecto(capo) {
		capo.encontrarCapo(self)
	}
	
	

}

object imagenes {
	
	method caballeroRolando() = "caballeroRolando.png"
	
	method caballeroCaterina() = "caballeroCaterina.png"
	
	method caballeroArchibaldo() = "caballeroArchibaldo.png"
	
}

object neblina {

	var property cosasOcultas = []

	method efecto(capo) {
		cosasOcultas.forEach({cosaOculta => capo.encontrarAlgo(cosaOculta)})
	}
	
	method imagenNeblina() = "neblina.png"

}

object espadaDelDestino {

	method puntosLucha(capo) = 3

	method puntosHechiceria(capo) = 0

	method efecto(capo) {
		capo.obtenerArtefacto(self)
	}

}

object libroDeHechizos {

	method puntosLucha(capo) = 0

	method puntosHechiceria(capo) = capo.hechiceriaBase()

	method efecto(capo) {
		capo.obtenerArtefacto(self)
	}

}

object collarDivino {

	method puntosLucha(capo) = 1

	method puntosHechiceria(capo) = 1

	method efecto(capo) {
		capo.obtenerArtefacto(self)
	}

}

//parte 2 
class Armadura {

	var property refuerzo = noRefuerzo
	var luchaBase = 2
	var hechiceriaBase = 0

	method puntosLucha(capo) = luchaBase + refuerzo.puntosLucha(capo)

	method puntosHechiceria(capo) = hechiceriaBase + refuerzo.puntosHechiceria(capo)

	method efecto(capo) {
		capo.obtenerArtefacto(self)
	}

}

object cotaDeMalla {

	method puntosLucha(capo) = 1

	method puntosHechiceria(capo) = 0
	
	 method efecto(capo) {}	
	

}

object bendicion {

	method puntosLucha(capo) = 0

	method puntosHechiceria(capo) = 1
	
	method efecto(capo) {}	
	

}

object hechizo {

	method puntosLucha(capo) = 0

	method puntosHechiceria(capo) = if (capo.hechiceriaBase() > 3) 2 else 0
	
	method efecto(capo) {}	
	

}

object noRefuerzo {

	method puntosLucha(capo) = 0

	method puntosHechiceria(capo) = 0

}

object espejoFantastico {

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

}

class CofrecitoDeOro {

	var property valor = 0

	method efecto(capo) {
		capo.bando().incrementarTesoro(valor)
	}	

}

class CumuloDeCarbon {

	const property valor = 50

	method efecto(capo) {
		capo.bando().incrementarReservaDeMateriales(valor)
	}

}

class ViejoSabio {

	var lucha = ayudanteDeSabio
	var hechiceria = null

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

}

object ayudanteDeSabio {

	var property lucha = 1

}

