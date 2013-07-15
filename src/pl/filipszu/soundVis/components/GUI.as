package pl.filipszu.soundVis.components{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import fl.controls.Button;
	import fl.controls.ColorPicker;
	import fl.controls.NumericStepper;
	import fl.events.ColorPickerEvent;
	
	import pl.filipszu.soundVis.events.GUIEvent;
	
	public class GUI extends Sprite{
		
		private var bg:Sprite = new Sprite();
		private var changeSongBtn:Button = new Button();
		private var changeFlowBtn:Button = new Button();
		private var colorPicker:ColorPicker = new ColorPicker();
		private var stepper:NumericStepper = new NumericStepper();
		
		public function GUI(){
			super();
			init();
		}
		
		private function init():void{
			createBG();
			createChangeMusicBtn();
			createColorPicker();
			createFlowBtn();
			createColumnInput();
		}
		
		private function createColorPicker():void{
			colorPicker.x = changeSongBtn.x - 10 - colorPicker.width;
			colorPicker.y = bg.y + (bg.height/2 - colorPicker.height/2);
			colorPicker.addEventListener(ColorPickerEvent.CHANGE, onColorChange);
			addChild(colorPicker);
		}
		
		private function onColorChange(e:ColorPickerEvent):void{
			var event:GUIEvent = new GUIEvent(GUIEvent.COLOR_CHANGE);
			event.color = e.color;	
			dispatchEvent(event);
		}
		
		
		private function createBG():void{
			
			bg.name = 'guiBG';
			bg.graphics.beginFill(0xFFFFFF, 0.9);
			bg.graphics.drawRect(0, 0, 400, 40);
			addChild(bg);
		}
		
		private function createChangeMusicBtn():void{
			
			changeSongBtn.label = 'Change Song';
			changeSongBtn.x = bg.width - 10 - changeSongBtn.width;
			changeSongBtn.y = bg.y + (bg.height/2 - changeSongBtn.height/2);
			changeSongBtn.addEventListener(MouseEvent.CLICK, onChangeSong);
			addChild(changeSongBtn);
		}
		
		private function createFlowBtn():void{	
			changeFlowBtn.label = 'Change Flow';
			changeFlowBtn.x = colorPicker.x - 10 - changeFlowBtn.width;
			changeFlowBtn.y = bg.y + (bg.height/2 - changeFlowBtn.height/2);
			changeFlowBtn.addEventListener(MouseEvent.CLICK, onChangeFlow);
			addChild(changeFlowBtn);
		}
		
		private function createColumnInput():void{	
			stepper.x = changeFlowBtn.x - 10 - stepper.width;
			stepper.y = bg.y + (bg.height/2 - stepper.height/2);
			stepper.maximum = 66;
			stepper.minimum = 4;
			stepper.stepSize = 2;
			stepper.value = 66;
			stepper.addEventListener(Event.CHANGE, onStepperChange);
			addChild(stepper);
		}
		
		protected function onStepperChange(e:Event):void{
			var event:GUIEvent = new GUIEvent(GUIEvent.COLUMN_CHANGE);
			event.columns = stepper.value;	
			dispatchEvent(event);
		}
		
		private function onChangeFlow(e:MouseEvent):void{
			dispatchEvent(new GUIEvent(GUIEvent.FLOW_CHANGE));
		}
		
		private function onChangeSong(e:MouseEvent):void{
			dispatchEvent(new GUIEvent(GUIEvent.SONG_CHANGE));
		}
		
	}
}