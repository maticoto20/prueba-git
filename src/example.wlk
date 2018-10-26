class Guerrero{ // hola
	var valorBaseHechiceria = 3
	var hechizoPreferido = hechizoBasico
	var valorBaseLucha = 1
	var artefactos = []
	var libroDeHechizos = [] 
	var oro = 50
//¿Qué sucede si el libro de hechizos incluye como hechizo al mismo libro de hechizos??
// se crea un loop infinito donde la lista contiene en uno de sus elementos a la misma lista, y asi sucesivamente.
	method valorArtefactos(){
		return artefactos.sum({artefacto => artefacto.unidadesDeLucha(self)}) 
	}
	method nivelHechiceria(){
		return valorBaseHechiceria * self.valorLibroDeHechizos() + fuerzaOscura.valor()
	}
	method cambiarHechizoPreferido(nuevoHechizo){
		hechizoPreferido = nuevoHechizo
	}
	method seCreePoderoso(){
		return libroDeHechizos.any({hechizo => hechizo.esPoderoso()}) //hechizoPreferido.esPoderoso() 
	}
	method habilidadDeLucha(){
		return valorBaseLucha + self.valorArtefactos()
	}
	method cambiarValorBaseLucha(nuevoValor){
		valorBaseLucha = nuevoValor
	}
	method agregarArtefacto(artefacto){
		artefactos.add(artefacto)
	}
	method removerArtefacto(artefacto){
		artefactos.remove(artefacto)
	}
	method luchaMayorAMagia(){
		return self.habilidadDeLucha() > self.nivelHechiceria()
	}
	method artefactos(){
		return artefactos
	}
	method libroHechizos(){
		return libroDeHechizos
	}
	method valorLibroDeHechizos(){
		return libroDeHechizos.filter({hechizo => hechizo.esPoderoso()}).sum({hechizo => hechizo.poder()})
	}
	method estaCargado(){
		return artefactos.size() <= 5
	}
	method eliminarArtefactos(){
		artefactos.clear()
	}
	method pagar(cantidad){
		oro -= cantidad
	}
}

class HechizoDeLogos{
// por que no se puede hacer una var poder = nombre.size() y despues que todos los methods devuelvan poder en vez de devolver nombre.size() en todos los methods??
// ya probe y cuando hago el cambiarNombre(), no me cambia el poder, sigue siendo el size de "espectro malefico"
	var nombre = "espectro malefico"
	method poder(){
		return nombre.size()
	}
	method esPoderoso(){
		return (self.poder() > 15)
	}
	method cambiarNombre(nuevoNombre){
		nombre = nuevoNombre
	}
	method unidadesDeLucha(luchador){
		return nombre.size()
	}	
	method nombre(){
		return nombre
	}
	method precio(){
		return nombre.size()
	}
}

object hechizoBasico{
	method poder(){
		return 10
	}
	method esPoderoso(){
		return false
	}
	method unidadesDeLucha(luchador){
		return 10
	}	
	method precio(){
		return 10
	}
}

object fuerzaOscura{
	var valor = 5
	method eclipse(){
		valor *= 2 //no funca, sigue devolviendo 5.....
	}
	method valor(){
		return valor
	}
}


//ARTEFACTOS
class ArmasDelDestino{
	var unidadesDeLucha = 3
	method unidadesDeLucha(luchador){
		return unidadesDeLucha
	}
	method precio(){
		return 5*unidadesDeLucha
	}
}

object collarDivino{
	var perlas = 1
	method unidadesDeLucha(luchador){
		return perlas
	}
	method cantidadPerlas(cantidad){
		perlas = cantidad
	}
	method precio(){
		return 2*perlas
	}
}

class MascaraOscura{
	var indiceOscuridad = 1
	method unidadesDeLucha(luchador){
		return 4.max(fuerzaOscura.valor() / 2 * indiceOscuridad)
	}
}

object espejo{
	method unidadesDeLucha(luchador){
		luchador.artefactos().remove(self)
		return luchador.artefactos().max({artefacto => artefacto.unidadesDeLucha(luchador)}).unidadesDeLucha(luchador)//return luchador.artefactos().fold(0,{art1,art2 => art1.unidadesDeLucha(luchador).max(art2.unidadesDeLucha(luchador))})
	}
	method precio(){
		return 90
	}	
}
// Es indistinto que haya muchos o un solo espejos o libros de hechizos, ya que son unicos y hacen lo mismo. Al estar en funcion de su portador, el efecto que tiene en estos es distinto para cada uno.


object libroDeHechizos{
	var hechizos = []
	method precio(){
		return hechizos.size() * 10 + hechizos.sum({hechizo => hechizo.poder()})
	}
}


//ARMADURA Y REFUERZOS
class Armadura{
	var unidadesDeLucha = 2
	var refuerzo = 0
	method agregarRefuerzo(objeto){
		refuerzo = objeto
	}
	method unidadesDeLucha(luchador){
		if(refuerzo.equals(0)){
			return unidadesDeLucha
		}
		else return unidadesDeLucha + refuerzo.unidadesDeLucha(luchador)
	}
	method precio(){
		return unidadesDeLucha + refuerzo.precio() 
	}
}

class CotaDeMalla{
	var unidadesDeLucha = 1
	method unidadesDeLucha(luchador){
		return unidadesDeLucha
	}
	method precio(){
		return unidadesDeLucha / 2
	}
}

object bendicion{
	method unidadesDeLucha(luchador){
		return luchador.nivelHechiceria()
	}
	method precio(){
		return 0
	}
}


//FERIA DE HECHIZOS
object feriaDeHechizos{
	method comprar(guerrero, objeto){
		objeto.precio()
	}
}





