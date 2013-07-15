/*
* Author: FilipSZU
* http://www.filipszu.pl/
* pl.filipszu.soundVis.SoundVisualizer
* May 12, 2012 
*/

package pl.filipszu.soundVis{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.BlurFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.sampler.NewObjectSample;
	import flash.utils.ByteArray;
	
	public class SoundVisualizer extends Sprite{
		
		private var canvas:Bitmap;
		private var canvasBD:BitmapData;
		private var vis:Sprite;
		public var columns:uint = 66;
		private var frameCount:uint = 0;
		
		private var _left:Boolean = false;
		
		public function set left(value:Boolean):void {
			_left = value;
			if(_left){
				mouseOffX = -3;
			}else{
				mouseOffX = 3;
			}
		}
		
		public function get left():Boolean {
			return _left;
		}
		
		private var mouseOffX:Number = 3;
		private var mouseOffY:Number = -2;
		private var currentMouseOffX:Number = 0;
		private var currentMouseOffY:Number = 0;
		private var draw:Boolean = false;
		private var screen:Sprite;
		private var color:uint = 0xFFFFFF;
		
		public function SoundVisualizer(){
			super();
			addEventListener(Event.ADDED_TO_STAGE, whenOnStage);
			
		}
		
		public function addTint(_color:uint):void{
			color = _color;
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
		
		public function drawSpectrum(ba:ByteArray):void{
			
			if(stage){
				vis.graphics.clear();
				
				var colmnsData:Array = new Array();
				var sum:Number = 0;
				for(var i:uint = 0; i < 512; i++){
					var num:Number = ba.readFloat();
					var delimiter:uint = 512 / columns;
					sum += num
					if(i%delimiter == 0){
						colmnsData.push(sum / delimiter);		
						sum = 0;
					}
				}
				
				for(i= 0; i < colmnsData.length; i++){
					var targX:Number =	(i * stage.stageWidth/columns);
					var targY:Number = -1*(colmnsData[i] * 400);
					var originY:Number = stage.stageHeight - 5;
					
					var alphaC:Number = 0.6;
					if(i%2!=0){
						alphaC = 0.8;
					}
					
					vis.graphics.lineStyle(1,0x000000, 0.5);
					vis.graphics.beginFill(color,alphaC);
					
					if(i >= columns / 2){
						var j:uint = columns - i + columns/2 - 1;
						
						targX = (j - columns/2) * stage.stageWidth/columns + (columns/2 * stage.stageWidth/columns);
						
						vis.graphics.beginFill(color, alphaC);	
					}
					
					vis.graphics.drawRect(targX, originY, stage.stageWidth/columns, targY);
					vis.graphics.endFill();
				}
			}
			
			//mouseOffX = -2 + ((stage.mouseX / (stage.stageWidth / 100)) * (4 / 100));
			//mouseOffY = -1 + ((stage.mouseY / (stage.stageHeight / 100)) * (-2 / 100));
			
			if(currentMouseOffX > mouseOffX  ){
				currentMouseOffX-= 0.2;
			}	
			
			if( currentMouseOffX < mouseOffX){
				currentMouseOffX += 0.2;
			}
			
			if(frameCount%2 == 0){
				frameCount = 0;
				
				
			
					
			
				
				if( currentMouseOffY < mouseOffY){
					currentMouseOffY+= 0.2;
				}
				
				if(currentMouseOffY > mouseOffY  ){
					currentMouseOffY-= 0.2;
				}
				
				canvas.bitmapData.scroll(currentMouseOffX, currentMouseOffY);
				
				if(!draw){
					canvas.bitmapData.draw(screen);
					//canvas.bitmapData.applyFilter(canvas.bitmapData, canvas.bitmapData.rect, new Point(0, 0), new BlurFilter(1.5, 1.5));
				}
				
				
				
				//canvas.bitmapData.colorTransform(displayBD.rect, colorTransform);
			}
			
			
			
			canvas.bitmapData.draw(vis);
		}
		
		private function createCanvas():void{
			canvasBD = new BitmapData(stage.stageWidth, stage.stageHeight, false, 0x000000);	
			canvas = new Bitmap(canvasBD);
			addChild(canvas);
			vis = new Sprite();
		}
		
		private function whenOnStage(e:Event):void{
			removeEventListener(Event.ADDED_TO_STAGE, whenOnStage);
			screen = new Sprite();
			screen.graphics.beginFill(0x000000, 0.04);
			screen.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			createCanvas();
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onPress);
			stage.addEventListener(MouseEvent.MOUSE_UP, onUp);
			
		}
		
		protected function onPress(event:MouseEvent):void{
			// TODO Auto-generated method stub
			draw = true;
		}
		
		protected function onUp(event:MouseEvent):void{
			// TODO Auto-generated method stub
			draw = false;
		}
		
	}
}