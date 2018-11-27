import viajes.*

class Socio {
	var property actividadesRealizadas = []
	var property  maximoDeActividades = 1
	var property edad = 18
	var property idiomasHablados = ["lengua materna"]
	
	method realizar(actividad){
		if(actividadesRealizadas.size() < maximoDeActividades){
		actividadesRealizadas.add(actividad)
		} else {
			self.error("ha llegado a su limite y no puede realizar mas actividades")
		}
	}
	
	method adoradorDelSol(){
		return actividadesRealizadas.all{ actividad => actividad.sirveParaBroncearse()}
	}
	
	method actividadesEsforzadas(){
		return actividadesRealizadas.map{ actividad => actividad.implicaEsfuerzo()}
	}
	
	method leAtrae(actividad){
		return true
	}
		
}

class SocioTranquilo inherits Socio {
	override method leAtrae(actividad){
		return actividad.dias() >= 4
	}
}

class SocioCoherente inherits Socio {
	override method leAtrae(actividad){
		return self.leGustaElBronceado(actividad) or actividad.implicaEsfuerzo()
		
	}
	
	method leGustaElBronceado(actividad){
		return self.adoradorDelSol() and actividad.sirveParaBroncearse()
	}
	
}

class SocioRelajado inherits Socio{
	override method leAtrae(actividad){
		return self.mismoIdioma(actividad)
	}
	
	method mismoIdioma(actividad){
		return idiomasHablados.contains(actividad.idiomas().get(1))
	}
}
