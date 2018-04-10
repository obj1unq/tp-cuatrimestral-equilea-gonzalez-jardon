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
 object armadura {
    
    var property ptosLucha = 3
    var property hechiceria = 0
    var property hechiceriaBase = 0
    
    method ptosHechiceria(capo) = 1 
    
    
    method obtenerRefuerzo(_unRefuerzo) {
        self.ptosLucha(self.ptosLucha()+ _unRefuerzo.ptosLucha())
        self.hechiceriaBase(self.hechiceria())
        self.hechiceria(self.hechiceria()+_unRefuerzo.ptosHechiceria(self))
    }
    
    method esEspejoFantastico() {
        return false
    }
    
}

object cotaDeMalla {
    const property ptosLucha = 1

    method ptosHechiceria(armadura) = 0 
    
}

object bendicion {
    const property ptosLucha = 1

    method ptosHechiceria(armadura) = 2

}

object hechizo {
    
    const property ptosLucha = 0
    
    method ptosHechiceria(capo) { 
        
        return if (capo.hechiceriaBase() > 3) capo.ptosHechiceria() + 2 else capo.hechiceria() 
     }

}

object espejoFantastico {
    
    var artefactos = #{}   
     
    method esEspejoFantastico() {
        return true
    }
    
    method refuerzosDisponibles(_unArtefacto) {
        artefactos.add(_unArtefacto)
    }

    method mejorArtefacto(capo){
        return capo.artefactos().filter({artefactoUsado => artefactoUsado.esEspejoFantastico()}).max({artefactoUsado => artefactoUsado.ptosHechiceria(capo) + artefactoUsado.ptosLucha()})
               
    }   
}

