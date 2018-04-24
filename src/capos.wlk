
object rolando {

	var property luchaBase = 3
	var property hechiceriaBase = 1
	const artefactos = #{}

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

	method encontrarElemento(_elemento) {
		_elemento.efecto(self)
	}

}

object espadaDelDestino {

	method puntosLucha(capo) = 3

	method puntosHechiceria(capo) = 0

}

object libroDeHechizos {

	method puntosLucha(capo) = 0

	method puntosHechiceria(capo) = capo.hechiceriaBase()

}

object collarDivino {

	method puntosLucha(capo) = 1

	method puntosHechiceria(capo) = 1

}

//parte 2 
object armadura {

	var property refuerzo = noRefuerzo
	var luchaBase = 2
	var hechiceriaBase = 0

	method puntosLucha(capo) = luchaBase + refuerzo.puntosLucha(capo)

	method puntosHechiceria(capo) = hechiceriaBase + refuerzo.puntosHechiceria(capo)
	
}

object cotaDeMalla {

	method puntosLucha(capo) = 1

	method puntosHechiceria(capo) = 0

}

object bendicion {

	method puntosLucha(capo) = 0

	method puntosHechiceria(capo) = 1

}

object hechizo {

	method puntosLucha(capo) = 0

	method puntosHechiceria(capo) = if (capo.hechiceriaBase() > 3) 2 else 0
	
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

	method artefactosSinEspejoFantastico(capo) = capo.artefactos().filter({ artefacto => artefacto != self })

	method mejorArtefacto(capo) = self.artefactosSinEspejoFantastico(capo).max({ artefacto => artefacto.puntosLucha(capo) + artefacto.puntosHechiceria(capo) })

}

//parte3
object bandoDelSur {

	var property tesoro = 0
	var property reservaDeMateriales = 0

	method incrementarTesoro(valor) {
		tesoro += valor
	}

	method incrementarReservaDeMateriales(valor) {
		reservaDeMateriales += valor
	}

}

object cofrecitoDeOro {

	method efecto(capo) {
		bandoDelSur.incrementarTesoro(100)
	}

}

object cumuloDeCarbon {

	method efecto(capo) {
		bandoDelSur.incrementarReservaDeMateriales(50)
	}

}

object viejoSabio {

	method efecto(capo) {
		capo.incrementarHechiceria()
		capo.incrementarLucha()
	}

}
