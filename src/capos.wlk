/** capos **/
object rolando {
	var property lucha = 3
	var property hechiceria = 1
	var property hechiceriaBase = 1
	const artefactos = #{}
	
	method artefactos() = artefactos
	
	method obtenerArtefacto(_artefacto) {
		artefactos.add(_artefacto)	
		self.lucha(self.lucha()+_artefacto.ptosLucha())
		self.hechiceriaBase(self.hechiceria())
		self.hechiceria(self.hechiceria()+_artefacto.ptosHechiceria(self))
	}
	
	method incLucha() {
		self.lucha(self.lucha()+1)	
	}

	method incHechiceria() {
		self.hechiceriaBase(self.hechiceria())
		self.hechiceria(self.hechiceria()+1)	
	}
}
 
object espadaDelDestino {
	const property ptosLucha = 3

	method ptosHechiceria(capo) = 0
}

object libroDeHechizos {
	const property ptosLucha = 0

	method ptosHechiceria(capo) = capo.hechiceriaBase()
}

object collarDivino {
	const property ptosLucha = 1
	
	method ptosHechiceria(capo) = 1
}

