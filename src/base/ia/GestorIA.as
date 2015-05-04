package base.ia
{
	import flash.display.Sprite;
	
	import base.niveles.mapa.Mapa;

	public class GestorIA
	{
		private var contexto:Mapa;
		
		public function GestorIA(contexto)
		{
			this.contexto = contexto;
		}
		
		private function verificarColisiones(capa:Sprite, heroe:Sprite):void
		{
			//por el momento se va a comprobar la colisión entre los demás carros
			//y liego la colisión entre los demás carros con el heroe
			verificarColisionesCapa(capa);
			verificarColisionCarrosHeroe(capa, heroe);
			
		}
		
		private function verificarColisionesCapa(capa:Sprite):void
		{
			var numChildren:int = capa.numChildren;
			for(var i:uint = 0; i< numChildren; i++)
			{
				for(var j:uint = 0; j< numChildren; j++)
				{
					if ((i != j)&&(capa.getChildAt(i).hitTestObject(capa.getChildAt(j))))
					{
						//acá se debe manejar la colisión con base a nuestro contexto que es el mapa
					}
				}	
			}
		}
		
		private function verificarColisionCarrosHeroe(capa:Sprite, heroe:Sprite):void
		{
			var numChildren:int = capa.numChildren;
			for(var i:uint = 0; i< numChildren; i++)
			{
				if ((capa.getChildAt(i).hitTestObject(heroe)))
				{
					//acá se debe manejar la colisión con base a nuestro contexto que es el mapa
				}
			}
		}
		
		//implementado pero no usado, se debe cambiar la lógica de las colisiones de acuerdo a la perspectiva
		private function colisionan(obj1:Sprite, obj2:Sprite):Boolean
		{
			//este método va a cambiar deacuerdo a la perspectiva, por ahora se utilizará este
			return obj1.hitTestObject(obj2);
		}
		
		public function update():Mapa
		{
			return this.contexto;
		}
		
		
	}
}