/*
* Author: FilipSZU
* http://www.filipszu.pl/
* Main
* May 12, 2012 
*/

package{
	
	import com.boostworthy.geom.ColorBar;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.media.SoundMixer;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.ByteArray;
	import flash.utils.getTimer;
	
	import pl.filipszu.soundVis.SoundVisualizer;
	import pl.filipszu.soundVis.components.GUI;
	import pl.filipszu.soundVis.events.GUIEvent;
	import pl.filipszu.soundVis.utils.SoundHandler;
	
	[SWF(width="1000", height="600", frameRate="30", backgroundColor="#000000")]
	
	public class Main extends Sprite{
		
		private var soundHandler:SoundHandler;
		private var visualizer:SoundVisualizer;
		private var last:uint = getTimer();
		private var ticks:uint = 0;
		private var fpsLabel:TextField;
		private var gui:GUI;
		
		public function Main(){
			super();
			addEventListener(Event.ADDED_TO_STAGE, whenOnStage);
			
		}
		
		private function whenOnStage(e:Event):void{
			removeEventListener(Event.ADDED_TO_STAGE, whenOnStage);
			init();
		}
		
		private function init():void{
			setStage();
			loadMusic();
			var label:TextField = new TextField();
			label.name = 'preloader';
			label.selectable = false;
			label.autoSize = TextFieldAutoSize.LEFT;
			var textFormat:TextFormat = new TextFormat('Arial', 22, 0xFFFFFF);
			label.defaultTextFormat = textFormat;
			label.text = 'Loading music please wait...';
			label.x = stage.stageWidth/2 - label.width/2;
			label.y = stage.stageHeight/2 - label.height/2;
			addChild(label);
		}
		
		private function createGUI():void{
			gui = new GUI(visualizer);
			addChild(gui);
		}
		
		private function setStage():void{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			fpsLabel = new TextField();
			fpsLabel.selectable = false;
			var textFormat:TextFormat = new TextFormat('Arial', 14, 0xFFFFFF);
			fpsLabel.defaultTextFormat = textFormat;
			fpsLabel.x = stage.stageWidth - 63;
			fpsLabel.y = stage.stageHeight - 25;
			
		}
		
		private function loadMusic():void{
			soundHandler = new SoundHandler(stage);
			soundHandler.addEventListener(Event.COMPLETE, onSongsLoaded);
			soundHandler.loadSongs(['assets/music/2.mp3', 'assets/music/1.mp3', 'assets/music/3.mp3']);
		}
		
		private function onSongsLoaded(e:Event):void{
			soundHandler.removeEventListener(Event.COMPLETE, onSongsLoaded);
			soundHandler.currentSong = 0;
			startVisualizer();
			createGUI();
		}
		
		private function startVisualizer():void{
			visualizer = new SoundVisualizer(new Point(0, stage.stageHeight * 0.7));
			addChild(visualizer);
			addChild(fpsLabel);
			addEventListener(Event.ENTER_FRAME, onLoop);
		}
		
		private function onLoop(e:Event):void{
			var ba:ByteArray = new ByteArray();
			SoundMixer.computeSpectrum(ba, true);
			visualizer.drawSpectrum(ba);
			tick(e);
		}
		
		public function tick(evt:Event):void {
			ticks++;
			var now:uint = getTimer();
			var delta:uint = now - last;
			if (delta >= 1000) {
				//trace(ticks / delta * 1000+" ticks:"+ticks+" delta:"+delta);
				var fps:Number = ticks / delta * 1000;
				fpsLabel.text = fps.toFixed(1) + " fps";
				ticks = 0;
				last = now;
			}
		}
		
	}
}