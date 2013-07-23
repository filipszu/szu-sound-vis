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
		
		public var color:Array = [0xFFFFFF, 0xFFFFFF, 0xFFFFFF];
		private var colorIndex = 0;
		private var colorCount = 0;
		
		private var mouseOffX:Number = 3;
		private var mouseOffY:Number = -2;
		private var currentMouseOffX:Number = 0;
		private var currentMouseOffY:Number = 0;
		private var draw:Boolean = false;
		private var screen:Sprite;
		public var regPoint:Point;
		
		public function SoundVisualizer(point:Point){
			super();
			regPoint = point;
			addEventListener(Event.ADDED_TO_STAGE, whenOnStage);
			
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
					var originY:Number = this.regPoint.y;
					
					var alphaC:Number = 0.6;
					if(i%2!=0){
						alphaC = 0.8;
					}
					
					vis.graphics.lineStyle(1,0x000000, 0.5);
					vis.graphics.beginFill(color[colorIndex],alphaC);
					
					if(i >= columns / 2){
						var j:uint = columns - i + columns/2 - 1;
						
						targX = (j - columns/2) * stage.stageWidth/columns + (columns/2 * stage.stageWidth/columns);
						
						vis.graphics.beginFill(color[colorIndex], alphaC);	
					}
					
					vis.graphics.drawRect(targX, originY, stage.stageWidth/columns, targY);
					vis.graphics.endFill();
				}
			}
			
			
			
					//currentMouseOffY+= 0.2;
				currentMouseOffX = 0.2;
				currentMouseOffY = 0.2;
				canvas.bitmapData.scroll(mouseOffX, mouseOffY);
				
				if(frameCount%3 == 0){	
					canvas.bitmapData.draw(screen);
				}
				
	
			//}
			
			if(frameCount%10 == 0){
				colorIndex++;
				if(colorIndex == color.length){
					colorIndex = 0;
				}
			}
			
			
			frameCount++;
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
			
		}
		
	}
}