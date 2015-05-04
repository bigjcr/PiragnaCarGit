package core.assets
{
	import flash.utils.Dictionary;
	
	import starling.errors.AbstractClassError;
	
	import util.string2IntList;

	public class AdministradorDJ
	{
		public static const xmlDJ:XML = Assets.getXML("DetallesJuego");
		
		private static var sCartas:Dictionary = 	new Dictionary();
		private static var sPestania:Dictionary = 	new Dictionary();
		private static var sElemento:Dictionary = 	new Dictionary();
		private static var sMisiones:Dictionary = 	new Dictionary();
		private static var sAcontecimientos:Dictionary = 	new Dictionary();
		
		/** @copy #prepararElemento() **/
		public static function obtenerElemento(nombre:String):Object
		{
			prepararElemento(nombre);
			return sElemento[nombre];
		}
		
		/**
		 * <code>
		 * <i>objeto</i>.nombre<br>
		 * <i>objeto</i>.tipo<br>
		 * <i>objeto</i>.terrenos<br>
		 * <i>objeto</i>.base<br>
		 * <i>objeto</i>.tiempoInactivo<br>
		 * <i>objeto</i>.valorAgua<br>
		 * <i>objeto</i>.valorDinero<br>
		 * <i>objeto</i>.nombreImagen<br>
		 * </code>
		 */		
		private static function prepararElemento(nombre:String):void
		{
			if (sElemento[nombre] == undefined)
			{
				var _xml:XML = xmlDJ.elementos.item.(@nombre==nombre)[0];
				
				var elemento:Object = new Object();
				
				
				elemento.nombre = _xml.@nombre;
				elemento.tipo = _xml.@tipo;
				elemento.terrenos = string2IntList(_xml.@terreno);
				elemento.base = _xml.@base;
				elemento.altura = _xml.@altura;
				elemento.pureza = _xml.@pureza;
				elemento.numeroTexturas = _xml.@numeroTexturas;
				elemento.nombreTextura = _xml.@nombreTexturas;
				elemento.nombreAtlas = _xml.@nombreAtlas;
				elemento.queGenera = _xml.@queGenera;
				elemento.genera = _xml.@genera;				
				elemento.tiempoGeneracion = _xml.@tiempoGeneracion*1000;
				elemento.tiempoInicialGeneracion = _xml.@tiempoInicialGeneracion*1000;
				elemento.nombreSonido = _xml.@nombreSonido;
				
				sElemento[nombre] = elemento;
			}
		}
		/** */
		public static function obtenerMision(id:String):Object
		{
			prepararMision(id);
			return sMisiones[id];
		}
		
		/**
		 * <code>
		 * <i>objeto</i>.id<br>
		 * <i>objeto</i>.nombre<br>
		 * <i>objeto</i>.objetivoNumerico<br>
		 * <i>objeto</i>.objetivoProgreso<br>
		 * <i>objeto</i>.objetivoTextual<br>
		 * </code>
		 */		
		private static function prepararMision(id:String):void
		{
			if (sMisiones[id] == undefined)
			{
				var elementoXml:XML = xmlDJ.misiones.item.(@id==id)[0];
				
				var mision:Object = new Object();
				mision.id = id;
				mision.nombre = elementoXml.@nombre;
				mision.objetivoNumerico = elementoXml.@objetivoNumerico;
				mision.objetivoProgreso = elementoXml.@objetivoProgreso;
				mision.objetivoTextual = elementoXml.@objetivoTextual;
				mision.desbloquearCartas = string2IntList(elementoXml.@desbloquearCartas);
				sMisiones[id] = mision;
			}
		}
		
		/** @copy #prepararAcontecimiento() **/
		public static function obtenerAcontecimiento(nombre:String):Object
		{
			prepararAcontecimiento(nombre);
			return sAcontecimientos[nombre];
		}
		
		/**
		 * <code>
		 * <i>objeto</i>.nombre<br>
		 * <i>objeto</i>.objetivoNumerico<br>
		 * <i>objeto</i>.objetivoCumplido<br>
		 * <i>objeto</i>.objetivoProgreso<br>
		 * <i>objeto</i>.tipo<br>
		 * <i>objeto</i>.Activo<br>
		 * <i>objeto</i>.objetivoTextual<br>
		 * </code>
		 */		
		private static function prepararAcontecimiento(nombre:String):void
		{
			if (sAcontecimientos[nombre] == undefined)
			{
				var xml:XML = xmlDJ.acontecimientos.item.(@nombre==nombre)[0];
				
				var objeto:Object = new Object();
				
				objeto.nombre = xml.@nombre;
				objeto.objetivoNumerico = xml.@objetivoNumerico;
				objeto.objetivoCumplido = xml.@objetivoCumplido;
				objeto.objetivoProgreso = xml.@objetivoProgreso;
				objeto.tipo = xml.@tipo;
				objeto.Activo = xml.@Activo=="si";
				objeto.objetivoTextual = xml.@objetivoTextual;
				
				sAcontecimientos[nombre] = objeto;
			}
		}
		
		/** @copy #prepararCarta() **/
		public static function obtenerCarta(elementoNombre:String):Object
		{
			prepararCarta(elementoNombre);
			return sCartas[elementoNombre];
		}
		
		/**
		 * <code>
		 * <i>objeto</i>.elementoNombre<br>
		 * <i>objeto</i>.titulo<br>
		 * <i>objeto</i>.pestania<br>
		 * <i>objeto</i>.estadoInicial<br>
		 * <i>objeto</i>.tiempoEnfriamiento<br>
		 * <i>objeto</i>.valorAgua<br>
		 * <i>objeto</i>.valorDinero<br>
		 * <i>objeto</i>.nombreImagen<br>
		 * <i>objeto</i>.numeroCompras<br>
		 * <i>objeto</i>.limiteCompras<br>
		 * <i>objeto</i>.fijo<br>
		 * <i>objeto</i>.fijoX<br>
		 * <i>objeto</i>.fijoY<br>
		 * </code>
		 */		
		private static function prepararCarta(elementoNombre:String):void
		{
			if (sCartas[elementoNombre] == undefined)
			{
				var cartaXml:XML = xmlDJ.cartas.item.(@elementoNombre==elementoNombre)[0];
				
				var carta:Object = new Object();
				carta.elementoNombre = cartaXml.@elementoNombre;
				carta.titulo = cartaXml.@titulo;
				carta.pestania = cartaXml.@pestanias;
				carta.estadoInicial = cartaXml.@estadoInicial;
				carta.tiempoEnfriamiento = cartaXml.@tiempoEnfriamiento //* 1000;--------------------------------------------------------
				carta.valorAgua = cartaXml.@valorAgua;
				carta.valorDinero = cartaXml.@valorDinero;
				carta.valorDinero = cartaXml.@valorDinero;
				carta.nombreImagen = cartaXml.@nombreImagen;
				carta.numeroCompras = cartaXml.@numeroCompras;
				carta.limiteCompras = cartaXml.@limiteCompras;
				carta.fijo = cartaXml.@fijo=="si";
				carta.fijoX = cartaXml.@fijoX;
				carta.fijoY = cartaXml.@fijoY;
				
				sCartas[elementoNombre] = carta;
			}
		}
		
		/** @copy #prepararPestania() **/
		/*public static function obtenerPestania(id:String):Object
		{
			prepararPestania(id);
			return sPestania[id];
		}*/
		
		/**
		 * <code>
		 * <i>objeto</i>.id<br>
		 * <i>objeto</i>.nombre<br>
		 * <i>objeto</i>.estadoInicial<br>
		 * <i>objeto</i>.nombreImagen<br>
		 * <i>objeto</i>.cartas<br>
		 * </code>
		 */		
		/*private static function prepararPestania(id:String):void
		{
			if (sPestania[id] == undefined)
			{
				var pestaniaXml:XML = xmlDJ.pestanias.item.(@id==id)[0];
				
				
				var pestania:Object = new Object();
				pestania.id = id;
				pestania.nombre = pestaniaXml.@nombre;
				pestania.estadoInicial = pestaniaXml.@estadoInicial;
				pestania.nombreImagen = pestaniaXml.@nombreImagen;
				pestania.cartas = pestaniaXml.@cartas;
				
				sPestania[id] = pestania;
			}
		}*/
		/**/
		public function AdministradorDJ() { throw new AbstractClassError(); }
		
		public static function numeroCartas():uint
		{			
			return xmlDJ.cartas.item.length();
		}
		
		public static function elementoNombreCartasN(i:uint):String
		{
			return xmlDJ.cartas.item[i].@elementoNombre;
		}
		
		public static function numeroAcontecimientos():uint
		{			
			return xmlDJ.acontecimientos.item.length();
		}
		
		public static function nombreAcontecimientosN(i:uint):String
		{			
			return xmlDJ.acontecimientos.item[i].@nombre;
		}
	}
}