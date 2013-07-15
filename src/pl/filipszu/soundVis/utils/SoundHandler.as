/*
* Author: FilipSZU
* http://www.filipszu.pl/
* pl.filipszu.soundVis.SoundVisualizer
* May 12, 2012 
*/
package pl.filipszu.soundVis.utils{
	
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.media.SoundMixer;
	import flash.ui.Keyboard;
	
	import br.com.stimuli.loading.BulkLoader;
	
	public class SoundHandler extends EventDispatcher{
		
		private var songList:Array;
		private var loader:BulkLoader;
		private var _stageRef:Stage;
		private var _currentSong:uint = 0;

		public function get currentSong():uint{
			return _currentSong;
		}

		public function set currentSong(value:uint):void{
			_currentSong = value;
			if(_currentSong > songList.length - 1){
				_currentSong = 0;
			}
			if(_currentSong < 0){
				_currentSong = songList.length - 1;
			}
			SoundMixer.stopAll();
			loader.getSound(currentSong.toString()).play();
		}

		
		public function SoundHandler(stageRef:Stage){
			super(null);
			_stageRef = stageRef;
		}
		
		public function loadSongs(_songList:Array):void{
			songList = _songList;
			loader = new BulkLoader("soundHanlder");
			loader.logLevel = BulkLoader.LOG_INFO;
			for(var i:uint = 0; i < songList.length; i++){
				loader.add(songList[i], {id: i});
			}
			loader.addEventListener(BulkLoader.COMPLETE, onAllItemsLoaded);
			loader.start();
		}
		
		private function onAllItemsLoaded(e:Event):void{
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
	}
}