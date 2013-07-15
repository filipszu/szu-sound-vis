package pl.filipszu.soundVis.events{
	import flash.events.Event;
	
	public class GUIEvent extends Event{
		
		public static const FLOW_CHANGE:String = 'FlowChange';
		public static const SONG_CHANGE:String = 'SongChange';
		public static const COLOR_CHANGE:String = 'ColorChange';
		public var color:uint = 0x000000;
		public static const COLUMN_CHANGE:String = 'ColumnChange';
		public var columns:uint = 0;
		public function GUIEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false){
			super(type, bubbles, cancelable);
		}
	}
}