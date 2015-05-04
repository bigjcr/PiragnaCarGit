package base.scenes
{
	import flash.display.Sprite;
	
	import base.ia.GestorIA;
	import base.niveles.mapa.Mapa;
	import starling.events.Event;

	public class RoadFighter extends Sprite
	{
		private var gestorIA:GestorIA;
		private var nivel:Mapa;
		
		private var gasolina:uint;
		private var score:uint;
		private var velocidad:uint;
		
		public function RoadFighter()
		{
		}
		
		private function onEnterFrame(e:Event):void
		{
			//hilo principal
			
			actualizarControles();
			actualizar();
			actualizarIA();
		}
		
		private function actualizarControles():void
		{
			// TODO Auto Generated method stub
			
		}
		
		private function actualizar()
		{
		
		}
		
		private function actualizarIA()
		{
			this.nivel = this.gestorIA.update();
		}
	}
}