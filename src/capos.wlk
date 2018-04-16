/** capos **/
object rolando {
	var property lucha = 3
	var property hechiceria = 1
	var property hechiceriaBase = 1
	const artefactos = #{}
	
	method artefactos() = artefactos
	
	method obtenerArtefacto(_artefacto) {
		artefactos.add(_artefacto)	
		self.lucha(self.lucha()+_artefacto.ptosLucha(self))
		self.hechiceria(self.hechiceria()+_artefacto.ptosHechiceria(self))
	}
	
	method incLucha() {
		self.lucha(self.lucha()+1)	
	}

	method incHechiceria(){
		self.hechiceriaBase(self.hechiceriaBase()+1)
		self.hechiceria(self.hechiceria()+1)	
	}
	
	method mejorArtefacto() {
		var artefactosSinEF=self.artefactos()
		   artefactosSinEF.remove(espejoFantastico)
		   return if(!artefactosSinEF.isEmpty()) artefactosSinEF.find({artefacto=>artefacto.ptosLucha(self)+artefacto.ptosHechiceria(self)==self.maximoArtefacto(artefactosSinEF)}) else artefactosSinEF
	} 
	                                   
	
	method encontrarElemento(_elemento){
		_elemento.efecto()
	}
	
	method maximoArtefacto(_artefactos) = _artefactos.map({artefacto=>artefacto.ptosLucha(self)+artefacto.ptosHechiceria(self)}).max() 
}

object espadaDelDestino{
	method ptosLucha(capo) = 3
	
	method ptosHechiceria(capo) = 0
}

object libroDeHechizos{
	method ptosLucha(capo) = 0
	
	method ptosHechiceria(capo) = capo.hechiceriaBase() 
}

object collarDivino{
	method ptosLucha(capo)= 1
	
	method ptosHechiceria(capo)=1 
}
//parte 2 
object armadura{
	var property refuerzo=0
	
	method ptosLucha(capo) = if(refuerzo!=0)2 + refuerzo.ptosLucha(capo) else 2
	
	method ptosHechiceria(capo) = if (refuerzo!=0) refuerzo.ptosHechiceria(capo) else 0 
}

object cotaDeMalla{
	method ptosLucha(capo) = 1
	method ptosHechiceria(capo) = 0 
}

object bendicion{
	method ptosLucha(capo) = 0
	method ptosHechiceria(capo) = 1
}

object hechizo{
	method ptosLucha(capo) = 0
	method ptosHechiceria(capo) = if(capo.hechiceriaBase()>3) 2 else 0 
}


object espejoFantastico{
   method ptosLucha(capo) = if(capo.mejorArtefacto()!= #{})
                              capo.mejorArtefacto().ptosLucha(capo) else 0
   method ptosHechiceria(capo) =if(capo.mejorArtefacto()!= #{})
                                 capo.mejorArtefacto().ptosHechiceria(capo) else 0   	
}

//parte3
object bandoDelSur{
   	var property tesoro=0
   	var property reservaDeMateriales=0
   	
   	method incTesoro(valor){
   		tesoro += valor
   	}
   	
   	method incReservaDeMateriales(valor){
   		reservaDeMateriales += valor
   	}
	
}
object cofrecitoDeOro{
	method efecto(){
		bandoDelSur.incTesoro(100)
	}
}

object cumuloDeCarbon{
	method efecto(){
		bandoDelSur.incReservaDeMateriales(50)
	}
}

object viejoSabio{
	method efecto(){
		rolando.incHechiceria()
		rolando.incLucha()
	}
}
//prueba
