/** capos **/
object rolando {
	var property lucha = 3
	var property hechiceria = 1
	var property hechiceriaBase = 1
	var artefactos = []
	
	method incLucha() {
		self.lucha(self.lucha()+1)	
	}

	method incHechiceria() {
		self.hechiceriaBase(self.hechiceria())
		self.hechiceria(self.hechiceria()+1)	
	}
	
	method obtenerArtefacto(artefacto) {
		artefactos.add(artefacto) 	
	}
}
/* 1er atisbo devuelve lista de puntos otorgados */
/*
object espadaDelDestino {
	
	method puntos() = [3,0]
}

object libroDeHechizos {
	
	method puntos(capo) = [capo.hechiceriaBase(),0]
}

object collarDivino {
	
	method puntos() = [1,1]
}
 */
 
object espadaDelDestino {
	const property ptosLucha = 3
	const property ptosHechiceria = 0	
}

object libroDeHechizos {
	const property ptosLucha = 0

	method ptosHechiceria(capo) = capo.hechiceriaBase()
}

object collarDivino {
	const property ptosLucha = 1
	const property ptosHechiceria = 1
}

