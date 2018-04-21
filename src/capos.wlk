/** capos **/

// FIXME: Veo que todos los commits son de la misma persona.
object rolando {
	var property lucha = 3
	// TODO ¿Por qué tenemos hechicería y también hechicería base?
	var property hechiceria = 1
	var property hechiceriaBase = 1
	const artefactos = #{}
	
	method artefactos() = artefactos
	
	// TODO Este precálculo no es adecuado para cumplir con los requerimientos.
	// En general, conviene evitar el cálculo "ansioso" ya que siempre requiere tener en cuenta más detalles.
	method obtenerArtefacto(_artefacto) {
		artefactos.add(_artefacto)	
		self.lucha(self.lucha()+_artefacto.ptosLucha(self))
		self.hechiceria(self.hechiceria()+_artefacto.ptosHechiceria(self))
	}
	
	// IDEA: Estas abreviaturas 'inc' complican la lectura innecesaria.
	method incLucha() {
		self.lucha(self.lucha()+1)	
	}

	method incHechiceria(){
		self.hechiceriaBase(self.hechiceriaBase()+1)
		self.hechiceria(self.hechiceria()+1)	
	}
	
	method mejorArtefacto() {
		var artefactosSinEF=self.artefactos()
		// FIXME Ojo que esta colección es la misma que la colección de rolando
		// Asignarla a otra variable no crea una colección nueva.
		// Son dos referencias al mismo objeto y al remover el espejo lo estoy removiendo de las dos.
		   artefactosSinEF.remove(espejoFantastico)
		   // IDEA: Esta línea es demasiado larga y complica la lectura.
		   return if(!artefactosSinEF.isEmpty()) 
		   // FIXME Por un lado del if devuevle yn artefacto y por el otro una lista.
		   // TODO El algoritmo es incorrecto.
		   	artefactosSinEF.find({artefacto=>artefacto.ptosLucha(self)+artefacto.ptosHechiceria(self)==self.maximoArtefacto(artefactosSinEF)}) else artefactosSinEF
	} 
	                                   
	
	method encontrarElemento(_elemento){
		_elemento.efecto()
	}

	// TODO Repite lógica de mejor artefacto, esto se puede hacer mucho más sencillo.
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
	
	// FIXME Primero piensa refuerzo como un número y 
	// después como un objeto refuerzo con ptosLucha y ptosHechiceria 
	
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
	// TODO El mejor artefacto no puede ser un conjunto!
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
// ???
//prueba
