class Viaje {
	var property idiomas = []
	//var property esfuerzo
	//var property sirveParaBroncease = true
	//var property dias = 1
	
	method sirveParaBroncearse() = true

    method implicaEsfuerzo() = true 
    
    method dias () 

   method esInteresante() = idiomas.size() > 1
	
}

class ViajeDePlaya inherits Viaje {
	var property largoDePlaya = 1
	
	override method dias() = largoDePlaya / 500 
	override method sirveParaBroncearse() = true
	
	override  method implicaEsfuerzo() = largoDePlaya > 1200
	
	
}

class ExcursionACiudad inherits Viaje {
	var property cantAtracciones 
	
	override method dias() = cantAtracciones / 2
	
	override method implicaEsfuerzo () {
		
	return cantAtracciones >= 5 and not self.sirveParaBroncearse()
}

 override method esInteresante() = super() or cantAtracciones == 5

 

}

class ViajeDeExcursionCiudadTropical inherits  ExcursionACiudad  {
	override method dias() = super() + 1
	
}

class SalidaDeTrekking inherits Viaje{
	var property kilometros
	var property diasDeSol 
	
	override method dias() = kilometros / 50
	
	override method implicaEsfuerzo() = kilometros > 80
	
	override method sirveParaBroncearse() {
		return diasDeSol > 200 or diasDeSol.between(100,200) and kilometros >120
	}
	
	override method esInteresante() = super() and diasDeSol > 140
}
