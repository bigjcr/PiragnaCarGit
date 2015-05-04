package core.assets
{
    import flash.display.Bitmap;
    import flash.media.Sound;
    import flash.text.Font;
    import flash.utils.ByteArray;
    import flash.utils.Dictionary;
    
    import starling.text.BitmapFont;
    import starling.text.TextField;
    import starling.textures.Texture;
    import starling.textures.TextureAtlas;

    public class Assets
    {
		private static var sContentScaleFactor:int = 1;
		private static var sTextures:Dictionary = new Dictionary();
		private static var sSounds:Dictionary = new Dictionary();
		private static var sTextureAtlas:Dictionary = new Dictionary();
		private static var sXML:Dictionary = new Dictionary();
		private static var sBitmapFontsLoaded:Boolean;
		
		
		public static function getTexture(name:String):Texture
		{
			if (sTextures[name] == undefined)
			{
				var data:Object = create(name);
				
				if (data is Bitmap)
					sTextures[name] = Texture.fromBitmap(data as Bitmap, true, false, sContentScaleFactor);
				else if (data is ByteArray)
					sTextures[name] = Texture.fromAtfData(data as ByteArray, sContentScaleFactor);
			}
			
			return sTextures[name];
		}
		
		public static function getAtlasTexture(atlasName:String,textureName:String):Texture
		{
			prepareAtlas(atlasName);
			return sTextureAtlas[atlasName].getTexture(textureName);
		}
		
		public static function getAtlasTextures(atlasName:String,prefix:String):Vector.<Texture>
		{
			prepareAtlas(atlasName);
			return sTextureAtlas[atlasName].getTextures(prefix);
		}
		
		public static function getMultipackAtlasTexture(atlasName:String,textureName:String):Texture
		{
			var textures:Texture;
			
			var atlasNum:int;
			atlasNum = 0;
			
			
			while(existAsset(atlasName + "_" + atlasNum + "_Texture"))
			{
				prepareAtlas(atlasName + "_" + atlasNum);
				
				textures = sTextureAtlas[atlasName + "_" + atlasNum].getTexture(textureName);
				var a:TextureAtlas
				
				if(textures) break;
				
				atlasNum++;
			}
			
			return textures;
		}
		
		public static function getMultipackAtlasTextures(atlasName:String,prefix:String):Vector.<Texture>
		{
			var textures1:Vector.<Texture>;
			textures1 = new Vector.<Texture>();
			
			var texturesName1:Vector.<String>;
			texturesName1 = new Vector.<String>();
			
			
			var textures2:Vector.<Texture>;
			var texturesName2:Vector.<String>;
			
			var atlasNum:int;
			atlasNum = 0;
			
			
			while(existAsset(atlasName + "_" + atlasNum + "_Texture"))
			{
				prepareAtlas(atlasName + "_" + atlasNum);
				textures2 = sTextureAtlas[atlasName + "_" + atlasNum].getTextures(prefix);
				texturesName2 = sTextureAtlas[atlasName + "_" + atlasNum].getNames(prefix);
				
				var i:int;
				i=0
				while(i < texturesName1.length && texturesName2.length > 0)
				{
					if(texturesName1[i] > texturesName2[0])
					{
						textures1.splice(i,0,textures2.shift());
						texturesName1.splice(i,0,texturesName2.shift());
					}
					i++;
				}
				
				if(texturesName2.length > 0)
				{
					texturesName1 = texturesName1.concat(texturesName2);
					textures1 = textures1.concat(textures2);
				}
				
				atlasNum++;
			}
			
			return textures1;
		}
		
		public static function getSound(name:String):Sound
		{
			prepareSounds(name)
			var sound:Sound = sSounds[name];
			if (sound) return sound;
			else throw new ArgumentError("Sound not found: " + name);
		}
		
		public static function getXML(name:String):XML
		{
			prepareXML(name)
			var xml:XML = sXML[name];
			if (xml) return xml;
			else throw new ArgumentError("XML not found: " + name);
		}
		
		public static function loadBitmapFonts(name:String):void
		{
			var texture:Texture = getTexture(name + "_Texture");
			var xml:XML = XML(create(name + "_Xml"));
			TextField.registerBitmapFont(new BitmapFont(texture, xml));
		}
		
		public static function loadFonts(name:String):void
		{
			Font.registerFont(AssetEmbeds[name]);
		}
		
		private static function prepareSounds(name:String):void
		{
			if (sSounds[name] == undefined)
			{
				sSounds[name] = new AssetEmbeds[name]() as Sound;
			}   
		}
		
		private static function prepareXML(name:String):void
		{
			if (sXML[name] == undefined)
			{
				sXML[name] = XML(new AssetEmbeds[name + "_Xml"]());
			}   
		}
		
		private static function prepareAtlas(name:String):void
		{
			if (sTextureAtlas[name] == undefined)
			{
				var texture:Texture = getTexture(name + "_Texture");
				var xml:XML = XML(create(name + "_Xml"));
				sTextureAtlas[name] = new TextureAtlas(texture, xml);
			}
		}
		
		private static function create(name:String):Object
		{
			var textureClass:Class = sContentScaleFactor == 1 ? AssetEmbeds_1x : AssetEmbeds_2x;
			return new textureClass[name];
		}
		
		private static function existAsset(name:String):Boolean
		{
			var exist:Boolean = sContentScaleFactor == 1 ? 
				AssetEmbeds_1x[name] : AssetEmbeds_2x[name];
			
			return exist;
		}
		
		
		public static function get contentScaleFactor():Number { return sContentScaleFactor; }
        public static function set contentScaleFactor(value:Number):void 
        {
			// falta algo ...........................
            for each (var texture:Texture in sTextures)
                texture.dispose();
            
            sTextures = new Dictionary();
            sContentScaleFactor = value < 1.5 ? 1 : 2; // assets are available for factor 1 and 2 
        }
    }
}