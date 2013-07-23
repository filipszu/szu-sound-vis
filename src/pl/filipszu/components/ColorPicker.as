package pl.filipszu.components{
	import com.boostworthy.geom.ColorBar;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	public class ColorPicker extends Sprite{
		
		private var specRect:ColorBar;
		private var colorLabel:TextField;
		private var marker:Sprite;
		private var _selectedColor:uint = 0xFFFFFF;
		private var indicator:Sprite;
		private var bd:BitmapData;
		private var b:Bitmap;
		public var id:uint = 0;
		
		public function get selectedColor():uint{
			return _selectedColor;
		}

		public function set selectedColor(value:uint):void{
			_selectedColor = value;
			setColor();
			dispatchEvent(new Event(Event.CHANGE));
		}

		
		public function ColorPicker(){
			super();
			init();
		}
		
		private function init():void{
			
			indicator = new Sprite();
			indicator.graphics.beginFill(0xFFFFFF, 1);
			indicator.graphics.drawRect(0, 0, 30, 30);
			addChild(indicator);
			colorLabel = new TextField();
			colorLabel.name = 'colorLabel';
			colorLabel.selectable = true;
			//colorLabel.type = TextFieldType.INPUT;
			//colorLabel.border = true;
			
			var textFormat:TextFormat = new TextFormat();
			textFormat.align = TextFormatAlign.CENTER;
			textFormat.color = 0xFFFFFF;
			textFormat.size = 25;
			textFormat.font = 'Arial';
			
			colorLabel.defaultTextFormat = textFormat;
			colorLabel.multiline = false;
			
			colorLabel.text = '#FFFFFF';
			colorLabel.borderColor = 0xFFFFFF;
			colorLabel.wordWrap = false;
			addChild(colorLabel);
			
			specRect = new ColorBar(200, 90);
			specRect.y = 33;
			colorLabel.x = 29;
			colorLabel.width = specRect.width-30;
			colorLabel.height = 30;
			
			addChild(specRect);
			
			specRect.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			
			marker = new Sprite();
			marker.graphics.lineStyle(2, 0x000000);
			marker.graphics.drawCircle(-2, -2, 4);
			marker.x = 2;
			marker.y = 2;
			specRect.addChild(marker);
			
			bd = new BitmapData(specRect.width, specRect.height);
			bd.draw(specRect);
			b = new Bitmap(bd);
			
		}
		
		private function setColor():void{
			
			var textFormat:TextFormat = new TextFormat();
			textFormat.align = TextFormatAlign.CENTER;
			textFormat.color = selectedColor;
			textFormat.size = 25;
			textFormat.font = 'Arial';
			colorLabel.defaultTextFormat = textFormat;
			colorLabel.text = '#'+displayInHex(selectedColor);
			colorLabel.borderColor = selectedColor;
			
			indicator.graphics.clear();
			indicator.graphics.beginFill(selectedColor, 1);
			indicator.graphics.drawRect(0, 0, 30, 30);
			
		}
		
		protected function onMouseDown(event:MouseEvent):void{
			specRect.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			specRect.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			specRect.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		
		private function onMouseMove(e:MouseEvent):void{
			setSelectedColor();
		}
		
		private function onMouseUp(event:MouseEvent):void{
			specRect.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			specRect.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			specRect.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			setSelectedColor();
		}
	
		private function setSelectedColor():void{
			var pX:Number = specRect.mouseX;
			var pY:Number = specRect.mouseY;
			marker.x = pX;
			marker.y = pY;
			
			selectedColor = b.bitmapData.getPixel(pX,pY);
		}
		
		private function displayInHex(c:uint):String {
			var r:String=extractRed(c).toString(16).toUpperCase();
			var g:String=extractGreen(c).toString(16).toUpperCase();
			var b:String=extractBlue(c).toString(16).toUpperCase();
			var hs:String="";
			var zero:String="0";
			if(r.length==1){
				r=zero.concat(r);
			}
			if(g.length==1){
				g=zero.concat(g);
			}
			if(b.length==1){
				b=zero.concat(b);
			}
			hs=r+g+b;
			return hs;
		}
		
		private function extractRed(c:uint):uint {
			return (( c >> 16 ) & 0xFF);
		}
		
		private function extractGreen(c:uint):uint {
			return ( (c >> 8) & 0xFF );
		}
		
		private function extractBlue(c:uint):uint {
			return ( c & 0xFF );
		}
		
	}
}