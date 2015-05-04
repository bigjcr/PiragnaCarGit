package
{
	import flash.desktop.NativeApplication;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import core.Constants;
	
	import scenes.Game;
	
	import starling.core.Starling;
	
	[SWF(frameRate="60", backgroundColor="#000000")]
	public class ProyectoCarro extends Sprite
	{
		private var starling:Starling;
		
		public function ProyectoCarro()
		{
			super();
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			Starling.multitouchEnabled = true;  // useful on mobile devices
			Starling.handleLostContext = false; // not necessary on iOS. Saves a lot of memory!
			
			var screenWidth:int  = stage.fullScreenWidth;
			var screenHeight:int = stage.fullScreenHeight;
			var viewPort:Rectangle = new Rectangle();
			
			if (screenHeight / screenWidth < Constants.ASPECT_RATIO)
			{
				viewPort.height = screenHeight;
				viewPort.width  = int(viewPort.height / Constants.ASPECT_RATIO);
				viewPort.x = int((screenWidth - viewPort.width) / 2);
			}
			else
			{
				viewPort.width = screenWidth; 
				viewPort.height = int(viewPort.width * Constants.ASPECT_RATIO);
				viewPort.y = int((screenHeight - viewPort.height) / 2);
			}
			
			var startupImage:Sprite = createStartupImage(viewPort, screenWidth > 320);
			addChild(startupImage);
			
			starling = new Starling(Game, stage, viewPort);
			
			starling.stage3D.addEventListener(Event.CONTEXT3D_CREATE, function(e:Event):void
			{
				// Starling is ready! We remove the startup image and start the game.
				removeChild(startupImage);
				startupImage = null;
				starling.start();
				
				//
				starling.simulateMultitouch = true;
				//starling.showStats = true;
			});
			
			NativeApplication.nativeApplication.addEventListener(Event.ACTIVATE, 
				function (e:Event):void { starling.start(); });
			
			NativeApplication.nativeApplication.addEventListener(Event.DEACTIVATE, 
				function (e:Event):void { starling.stop(); });
		}
		
		private function createStartupImage(viewPort:Rectangle, isHD:Boolean):Sprite
		{
			var sprite:Sprite = new Sprite();
			
			/*var background:Bitmap = isHD ?
				new AssetEmbeds_2x.FondoInicio() : new AssetEmbeds_1x.FondoInicio();
			
			background.smoothing = true;
			sprite.addChild(background);
			
			var cargando:Bitmap = isHD ?
				new AssetEmbeds_2x.Cargando() : new AssetEmbeds_1x.Cargando();
			
			cargando.smoothing = true;
			cargando.x = Constants.STAGE_WIDTH*2-cargando.width-64;
			cargando.y = Constants.STAGE_HEIGHT*2-cargando.height-64;
			sprite.addChild(cargando);
			
			sprite.x = viewPort.x;
			sprite.y = viewPort.y;
			sprite.width  = viewPort.width;
			sprite.height = viewPort.height;
			*/
			return sprite;
		}
	}
}