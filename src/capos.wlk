class Capo {

	// si le pongo null a la variable "bando" no funcionan los test porque no reconoce la referencia del mismo
	var property bando = 1
	var property luchaBase = null
	var property hechiceriaBase = null
	var property artefactos = []
	var puntoDeVida
	var property posicion = game.at(2, 3)
	var property imagen = null

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
		if (self.sumaDeValores(self) >= self.sumaDeValores(capo)) {
			capo.matarCapo()
			game.removeVisual(capo)
		} else self.matarCapo()
		game.removeVisual(self)
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

	method llego(capo) {
		self.encontrarCapo(capo)
	}

}

class Neblina {

	var property posicion = game.at(6, 6)
	var property imagen = "niebla.png"
	var property cosasOcultas = []

	method efecto(capo) {
		cosasOcultas.forEach({ cosaOculta => capo.encontrarAlgo(cosaOculta)})
		game.removeVisual(self)
	}

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
    
    method efecto(capo){}
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
	
	method efecto(capo){}

	method llego(capo) {
	}

}

class CofrecitoDeOro {

	var property valor = 0
	var imagen = "cofre.png"

	method efecto(capo) {
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

