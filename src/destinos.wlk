class Viaje {
	var property idiomasUsados
	method seUsaIdioma(idioma) = idiomasUsados.contains(idioma)
	method esRecomendadoPara(socio) = self.esInteresante() and socio.leAtrae(self) and not socio.hizoActividad(self)
	
	method esInteresante() = self.idiomasUsados().size() > 1
}

class ViajeDePlaya inherits Viaje {
	var property extension
	
	method diasActividad() = extension / 500
	method implicaEsfuerzo() = extension > 1200
	method sirveParaBroncearse() = true
}

class ExcursionACiudad inherits Viaje {
	var property cantidadAtracciones 
	
	method diasActividad() = cantidadAtracciones / 2
	method implicaEsfuerzo() = cantidadAtracciones > 6
	method sirveParaBroncearse() = false
	override method esInteresante() = super() or cantidadAtracciones == 5
}

class ExcursionACiudadTropical inherits ExcursionACiudad {
	override method diasActividad() = super() + 1
	override method sirveParaBroncearse() = true
}

class SalidaDeTrekking inherits Viaje {
	var property kilometros
	var property diasDeSolPorAnio
	
	method diasActividad() = kilometros / 50
	method implicaEsfuerzo() = kilometros > 80
	method sirveParaBroncearse() = diasDeSolPorAnio > 200 or (diasDeSolPorAnio > 100 and kilometros > 120)	 
	override method esInteresante() = super() and diasDeSolPorAnio > 140
}


// una actividad que no es un viaje
class ClaseDeGimnasia {
	method idiomasUsados() = ["español"]
	method diasActividad() = 1
	method implicaEsfuerzo() = true
	method sirveParaBroncearse() = false
	method esRecomendadoPara(socio) = socio.edad().between(20,30)	 
}


class Socio {
	var property actividadesRealizadas
	var property maximaCantidadActividades
	var property idiomasQueHabla
	var property edad
	
	method registrarActividad(actividad) {
		if (actividadesRealizadas.size() >= maximaCantidadActividades) {
			self.error("Llegó al máximo de las actividades que puede hacer")
		}
		actividadesRealizadas.add(actividad)
	}

	method esAdoradorDelSol() = actividadesRealizadas.all { act => act.sirveParaBroncearse() }
	method actividadesEsforzadas() = actividadesRealizadas.filter { act => act.implicaEsfuerzo() }

	method hablaIdioma(idioma) = idiomasQueHabla.contains(idioma)
	method hizoActividad(actividad) = actividadesRealizadas.contains(actividad)
}

class SocioTranquilo inherits Socio {
	method leAtrae(actividad) = actividad.diasActividad() >= 4
}

class SocioCoherente inherits Socio {
	method leAtrae(actividad) {
		if (self.esAdoradorDelSol()) {
			return actividad.sirveParaBroncearse()
		} else {
			return actividad.implicaEsfuerzo()
		}	
	}
}

class SocioRelajado inherits Socio {
	method leAtrae(actividad) = actividad.sirveParaBroncearse() and actividad.idiomasUsados().any {idioma => self.hablaIdioma(idioma) } 
}



// otra actividad, podría ser un último punto

class Libro {
	var property idioma	
	var property cantidadDePaginas
	var property nombreAutor
}

class TallerLiterario {
	var property libros
	
	method idiomasUsados() = libros.map { libro => libro.idioma() } .asSet()
	method diasActividad() = libros.size() + 1
	method implicaEsfuerzo() = libros.any { libro => libro.cantidadDePaginas() > 500 } or self.sonVariosLibrosDelMismoAutor()
	method sonVariosLibrosDelMismoAutor() {
		const unAutor = libros.anyOne().nombreAutor()
		return libros.size() > 1 and libros.all { libro => libro.nombreAutor() == unAutor } 
	}
	method sirveParaBroncearse() = false	 
	method esRecomendadoPara(socio) = socio.idiomasQueHabla().size() > 1	 
}
 
 
