package scenes
{
	import core.assets.Assets;
	
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class Game extends Sprite
	{
		private var btnIzq:Quad;
		private var btnDer:Quad;
		private var left:Boolean;
		private var right:Boolean;
		private var sp:Sprite;
		
		private var mapArray:Array = [];
		
		//capas
		private var capa1:Sprite;
		private var capa2:Sprite;
		private var capa3:Sprite;
		private var capa4:Sprite;
		
		public function Game()
		{
			super();
			for(var i:uint = 0; i<120; i++){
				mapArray[i] = i%2;//Math.floor(Math.random()*0);
			}
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void
		{
			//var fdo:Image = new Image(Assets.getTexture("fondo"));
			//addChild(fdo);
			
			sp = new Sprite();
			var img:Image = new Image(Assets.getTexture("carro"));
			sp.x = 350;
			sp.y = 450;
			sp.addChild(img);
			
			capa1 = new Sprite();
			addChild(capa1);
			capa2 = new Sprite();
			addChild(capa2);
			capa3 = new Sprite();
			addChild(capa3);
			capa4 = new Sprite();
			addChild(capa4);
			
			
			capa3.addChild(sp);
			
			//controles
			btnIzq = new Quad(512, 768, 0xffffff);
			btnIzq.alpha = .0;
			btnDer = new Quad(512, 768, 0xffffff);
			btnDer.x = 512;
			btnDer.alpha = .0;
			addChild(btnIzq);
			addChild(btnDer);
			
			btnIzq.addEventListener(TouchEvent.TOUCH, touchHandler);
			btnDer.addEventListener(TouchEvent.TOUCH, touchHandler);
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			
			/**build terrain*/
			for(var i:uint; i<mapArray.length; i++){
				var sep1:Image = new Image(Assets.getTexture("sepArriba"));;
				capa1.addChild(sep1);
				
				var piso:Image;
				
				
				var sep2:Image = new Image(Assets.getTexture("sepAbajo"));
				capa4.addChild(sep2);
				
				switch(mapArray[i]){
					case 0:
						piso = new Image(Assets.getTexture("pisoLineaDoble"));				
						break;
					case 1:
						piso = new Image(Assets.getTexture("pisoVacio"));
						break;					
				}
				sep1.x = 41*i;
				piso.x = 36*i;
				sep2.x = 41*i;
				sep1.y = 250-18.5*i;
				piso.y = 250-16.25*i;
				sep2.y = 250-18.5*i;
				capa2.addChild(piso);
			}
			ordenarElementos(capa1);
			ordenarElementos(capa4);
		}
		public function ordenarElementos(map:Sprite):void
		{
			/*var N:uint = 1;
			
			while (N < map.numChildren) {
				var i:int = 0;
				var n:int = N + 1;
				do {
					if (map.getChildAt(N).y > map.getChildAt(i-1+(n%2 + n)/2).y) {
						//--->>>
						i += (n%2 + n)/2;
						n = (n - n % 2) / 2;
					} else {
						n = (n + n % 2) / 2 - 1;
					}
				} while (n>0);
				
				/*map.elementos.splice(i,0,map.elementos[N]);
				map.elementos.splice(N+1,1);*/
				/*N++;
			}
			*/
			/*for (var i:uint=0; i<map.numChildren; i++) {
				for (var j:uint=0; j<map.numChildren; j++) {
					if(map.getChildAt(i).y > map.getChildAt(j).y){
						map.addChild(map.getChildAt(i));
					}
				}				
			}*/
			for(var i:int = map.numChildren-1; i>=0; i--){
				map.addChild(map.getChildAt(i));
			}
		}
		private function touchHandler(e:TouchEvent):void
		{
			var target:DisplayObject = e.currentTarget as DisplayObject;
			var touch:Touch = e.getTouch(target);
			if(!touch)return;
			if(touch.phase == TouchPhase.BEGAN){
				if(target == btnIzq){
					left = true;
				} else if(target == btnDer){
					right = true;
				}
			} else if(touch.phase == TouchPhase.ENDED){
				if(target == btnIzq){
					left = false;
				} else if(target == btnDer){
					right = false;
				}
			}
		}
		
		private var accF:Number = .5*.55;
		private var velX:Number = 0;
		private var velY:Number = 0;
		private var accX:Number = 0;
		private var accY:Number = 0;
		private var fr:Number = .93;
		
		//piso
		private var accPx:Number = .75;
		private var accPy:Number = .375;
		private var velPx:Number = 0;
		private var velPy:Number = 0;
		private function onEnterFrame(e:Event):void{
			velPx += accPx;
			velPx *= fr;
			velPy += accPy;
			velPy *= fr;
			capa1.y+=velPy*.9035;
			capa1.x-=velPx;
			capa2.y+=velPy*.9035;
			capa2.x-=velPx;
			capa4.y+=velPy*.9035;
			capa4.x-=velPx;
			 if(left){
				 accX = -accF;
				 accY = -accF;
			 } else if(right){
				 accX = accF;
				 accY = accF;
			 } else {
				 accX = 0;
				 accY = 0;
			 }
			 if(left && right){
				 accX = 0;
				 accY = 0;
			 }
			 velX += accX;
			 velX *= fr;
			 
			 velY += accY;
			 velY *= fr;
			 
			 sp.x += velX;
			 sp.y += velY;
		}
	}
}