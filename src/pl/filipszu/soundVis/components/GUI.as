package pl.filipszu.soundVis.components{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import pl.filipszu.components.ColorPicker;
	import pl.filipszu.soundVis.SoundVisualizer;
	
	public class GUI extends Sprite{
		
		private var pickersHolder:Sprite;
		private var soundVis:SoundVisualizer;
		
		public function GUI(vis){
			super();
			soundVis = vis;
			addEventListener(Event.ADDED_TO_STAGE, whenOnStage);
			init();
		}
		
		private function whenOnStage(e:Event):void{
			removeEventListener(Event.ADDED_TO_STAGE, whenOnStage);
			layout();
		}
		
		public function layout():void{
			pickersHolder.y = stage.stageHeight * 0.75;
			pickersHolder.x = stage.stageWidth /2 - pickersHolder.width/2;
		}
		
		private function init():void{
			createColorPickers();
		}
		
		private function createColorPickers():void{
			pickersHolder = new Sprite();	
			var picker1:ColorPicker = new ColorPicker();
			picker1.x = 0;
			picker1.y = 0;
			picker1.id = 0;
			pickersHolder.addChild(picker1);
			
			var picker2:ColorPicker = new ColorPicker();
			picker2.x = picker1.x + picker1.width + 50;
			picker2.y = 0;
			picker2.id = 1;
			pickersHolder.addChild(picker2);
			
			var picker3:ColorPicker = new ColorPicker();
			picker3.x = picker2.x + picker2.width + 50;
			picker3.y = 0;
			pickersHolder.addChild(picker3);
			picker3.id = 2;
			addChild(pickersHolder);
			
			picker1.addEventListener(Event.CHANGE, onColor1Change);
			picker2.addEventListener(Event.CHANGE, onColor1Change);
			picker3.addEventListener(Event.CHANGE, onColor1Change);
		}
		
		private function onColor1Change(e:Event):void{
			var picker:ColorPicker = e.target as ColorPicker;
			soundVis.color[picker.id] = picker.selectedColor;
		}
		
	}
}