/** capos **/ // FIXME: Veo que todos los commits son de la misma persona.
object rolando {

	var property luchaBase = 3
	var property hechiceriaBase = 1
	const artefactos = #{}

	method artefactos() = artefactos

	method obtenerArtefacto(_artefacto) {
		artefactos.add(_artefacto)
	}
	
	method valorHechiceria() = hechiceriaBase + artefactos.sum({artefacto => artefacto.puntosHechiceria(self)})
	
	method valorLucha() = luchaBase + artefactos.sum({artefacto => artefacto.puntosLucha()})
		
	method incrementarLucha() {
		lucha += 1
	}

	method incrementarHechiceria() {
		hechiceria +=1
	}

	method mejorArtefacto() {
		var artefactosSinEF = self.artefactos()
			// FIXME Ojo que esta colección es la misma que la colección de rolando
			// Asignarla a otra variable no crea una colección nueva.
			// Son dos referencias al mismo objeto y al remover el espejo lo estoy removiendo de las dos.
		artefactosSinEF.remove(espejoFantastico)
			// IDEA: Esta línea es demasiado larga y complica la lectura.
		return if (!artefactosSinEF.isEmpty()) // FIXME Por un lado del if devuevle yn artefacto y por el otro una lista.
		// TODO El algoritmo es incorrecto.
		artefactosSinEF.find({ artefacto => artefacto.ptosLucha(self) + artefacto.ptosHechiceria(self) == self.maximoArtefacto(artefactosSinEF) }) else artefactosSinEF
	}

	method encontrarElemento(_elemento) {
		_elemento.efecto()
	}

	// TODO Repite lógica de mejor artefacto, esto se puede hacer mucho más sencillo.
	method maximoArtefacto(_artefactos) = _artefactos.map({ artefacto => artefacto.ptosLucha(self) + artefacto.ptosHechiceria(self) }).max()

}

object espadaDelDestino {

	method puntosLucha() = 3

	method puntosHechiceria(capo) = 0

}

object libroDeHechizos {

	method puntosLucha() = 0

	method puntosHechiceria(capo) = capo.hechiceriaBase()

}

object collarDivino {

	method puntosLucha() = 1

	method puntosHechiceria(capo) = 1

}

//parte 2 
object armadura {

	var property refuerzo = null
	var luchaBase = 2
	var hechiceriaBase = 0
	
	method puntosLucha() =  luchaBase + refuerzo.ptosLucha()

	method puntosHechiceria(capo) = hechiceriaBase + refuerzo.puntosHechiceria(capo)

}

object cotaDeMalla {

	method puntosLucha() = 1

	method puntosHechiceria(capo) = 0

}

object bendicion {

	method puntosLucha() = 0

	method puntosHechiceria(capo) = 1

}

object hechizo {

	method puntosLucha() = 0

	method puntosHechiceria(capo) = if (capo.hechiceriaBase() > 3) 2 else 0

}

object espejoFantastico {

	// TODO El mejor artefacto no puede ser un conjunto!
	method ptosLucha(capo) = if (capo.mejorArtefacto() != #{}) capo.mejorArtefacto().ptosLucha(capo) else 0

	method ptosHechiceria(capo) = if (capo.mejorArtefacto() != #{}) capo.mejorArtefacto().ptosHechiceria(capo) else 0

}

//parte3
object bandoDelSur {

	var property tesoro = 0
	var property reservaDeMateriales = 0

	method incTesoro(valor) {
		tesoro += valor
	}

	method incReservaDeMateriales(valor) {
		reservaDeMateriales += valor
	}

}

object cofrecitoDeOro {

	method efecto() {
		bandoDelSur.incTesoro(100)
	}

}

object cumuloDeCarbon {

	method efecto() {
		bandoDelSur.incReservaDeMateriales(50)
	}

}

object viejoSabio {

	method efecto() {
		rolando.incHechiceria()
		rolando.incLucha()
	}

}

// ???
//prueba
