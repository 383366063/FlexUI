package org.lanelife.framework.components.datetime
{
	import flash.events.MouseEvent;
	
	import spark.components.Label;
	import spark.components.ToggleButton;
	
	public class DayButton extends ToggleButton
	{
		[SkinState("upAndNotInCurrentMonth")]
		[SkinState("overAndNotInCurrentMonth")]
		[SkinState("downAndNotInCurrentMonth")]
		[SkinState("disabledAndNotInCurrentMonth")]
		
		[SkinPart(required="true")]
		public var dayDisplay:Label;
		
		private var _date:Date;
		private var datePropertyChanged:Boolean=false;
		
		[Bindable]
		public function get date():Date
		{
			return _date;
		}
		
		public function set date(value:Date):void
		{
			_date = value;
			invalidateDateProperties();
		}
		
		public function invalidateDateProperties():void
		{
			if (datePropertyChanged)
				return;
			datePropertyChanged=true;
			invalidateProperties();
		}
		
		protected function commitDateProperties():void
		{
			if (dayDisplay) {
				dayDisplay.text = date.date.toString();
			}
		}
		
		override public function set selected(value:Boolean):void
		{
			super.selected = value;
			if (value) {
				this.depth = 100;
			} else {
				this.depth = 0;
			}
		}
		
		private var _notInCurrentMonth:Boolean = false;
		
		public function get notInCurrentMonth():Boolean
		{
			return _notInCurrentMonth;
		}
		
		public function set notInCurrentMonth(value:Boolean):void
		{
			_notInCurrentMonth = value;
			invalidateSkinState();
		}
		
		
		public function DayButton()
		{
			super();
			this.addEventListener(MouseEvent.MOUSE_OVER, function(event:MouseEvent):void{
				depth = 100;
			});
			this.addEventListener(MouseEvent.MOUSE_OUT, function(event:MouseEvent):void{
				if (!selected)
					depth = 0;
			});
		}
		
		override protected function partAdded(partName:String, instance:Object):void
		{
			super.partAdded(partName, instance);
			
			if (instance == dayDisplay) {
				commitDateProperties();
			}
		}
		
		override protected function getCurrentSkinState():String
		{
			var state:String=super.getCurrentSkinState();
			if (notInCurrentMonth && !selected)
				state = state+"AndNotInCurrentMonth";
			return state;
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			if (datePropertyChanged) {
				commitDateProperties();
				datePropertyChanged=false;
			}
		}
	}
}