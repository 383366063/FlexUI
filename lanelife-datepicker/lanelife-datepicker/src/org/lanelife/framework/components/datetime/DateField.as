package org.lanelife.framework.components.datetime
{
	import flash.events.MouseEvent;
	
	import mx.core.FlexGlobals;
	import mx.formatters.DateFormatter;
	
	import spark.components.Image;
	import spark.components.PopUpAnchor;
	import spark.components.TextInput;
	
	public class DateField extends TextInput
	{
		[SkinPart(required="true")]
		public var dateIcon:Image;
		
		[SkinPart(required="true")]
		public var popUpAnchor:PopUpAnchor;
		
		[SkinPart(required="true")]
		public var datetimePicker:DatetimePicker;
		
		[Bindable]
		public var formatString:String = "YYYY-MM-DD";
		
		[Bindable]
		public var style:String = DatetimePicker.STYLE_DATE;
		
		private var _selectedDate:Date;

		[Bindable]
		public function get selectedDate():Date
		{
			return _selectedDate;
		}

		public function set selectedDate(value:Date):void
		{
			_selectedDate = value;
			var df:DateFormatter = new DateFormatter();
			df.formatString = formatString;
			text = df.format(selectedDate);
		}

		
		public function DateField()
		{
			super();
			FlexGlobals.topLevelApplication.addEventListener(MouseEvent.MOUSE_DOWN, function(e:MouseEvent):void{
				popUpAnchor.displayPopUp = false;
			});
			this.addEventListener(MouseEvent.CLICK, function(event:MouseEvent):void{
				showDatetimePicker();
			});
			this.editable = false;
		}
		
		private function showDatetimePicker():void
		{
			popUpAnchor.displayPopUp = true;
			var dt:Date = selectedDate;//DateFormatter.parseDateString(text);
			if (dt==null) dt = new Date();
			datetimePicker.selectedDate = dt;
			datetimePicker.style = style;
			datetimePicker.updateYearMonth();
		}
		
		override protected function partAdded(partName:String, instance:Object):void
		{
			super.partAdded(partName, instance);
			
			if (instance == dateIcon) {
				dateIcon.addEventListener(MouseEvent.CLICK, function(event:MouseEvent):void{
					showDatetimePicker();
				});
			} else if (instance == datetimePicker) {
				datetimePicker.dateField = this;
			}
		}
	}
}