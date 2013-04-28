package org.lanelife.framework.components.datetime
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.formatters.DateFormatter;
	
	import spark.components.Button;
	import spark.components.SkinnableContainer;
	import spark.components.TileGroup;
	
	public class DatetimePicker extends SkinnableContainer
	{
		private static const STATE_DAYS:String = "days";
		private static const STATE_MONTHS:String = "months";
		private static const STATE_YEARS:String = "years";
		
		[SkinState("days")]
		
		[SkinState("months")]
		
		[SkinState("years")]
		
		private var _state:String = STATE_DAYS;

		public function get state():String
		{
			return _state;
		}

		public function set state(value:String):void
		{
			_state = value;
			if (state==STATE_YEARS) {
				createYearButtons();
			}
			invalidateSkinState();
		}
		
		public static const STYLE_DATE:String = "date";
		public static const STYLE_DATETIME:String = "datetime";
		
		[Bindable]
		public var style:String = STYLE_DATE;

		
		[SkinPart(required="true")]
		public var yearMonthButton:Button;
		
		[SkinPart(required="true")]
		public var prevMonthButton:Button;
		
		[SkinPart(required="true")]
		public var nextMonthButton:Button;
		
		[SkinPart(required="true")]
		public var prevPageYearsButton:Button;
		
		[SkinPart(required="true")]
		public var nextPageYearsButton:Button;
		
		[SkinPart(required="true")]
		public var todayButton:Button;
		
		[SkinPart(required="true")]
		public var confirmButton:Button;
		
		[SkinPart(required="true")]
		public var clearButton:Button;
		
		[SkinPart(required="true")]
		public var yearsTileGroup:TileGroup;
		
		[SkinPart(required="true")]
		public var monthsTileGroup:TileGroup;
		
		[SkinPart(required="true")]
		public var daysTileGroup:TileGroup;
		
		[SkinPart(required="true")]
		public var timePicker:TimePicker;
		
		public var dateField:DateField;
		
		[Bindable]
		public var years:ArrayCollection = new ArrayCollection();
		
		private var _yearIndex:Number = -1;

		[Bindable]
		public function get yearIndex():Number
		{
			if (_yearIndex==-1) {
				for (var i:int=0; i<years.length; i++) {
					var ys:ArrayCollection = years.getItemAt(i) as ArrayCollection;
					if (ys.contains(year)) {
						return i;
					}
				}
			}
			return _yearIndex;
		}

		public function set yearIndex(value:Number):void
		{
			_yearIndex = value;
		}

		
		[Bindable]
		public var months:ArrayCollection = new ArrayCollection(["一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"]);
		
		[Bindable]
		public var weeks:ArrayCollection = new ArrayCollection(["日","一","二","三","四","五","六"]);
		
		public function getDays(month:Number):Number
		{
			var ds:Array = [31,(this.year%4==0?29:28),31,30,31,30,31,31,30,31,30,31];
			return ds[month];
		}
		
		[Bindable]
		public var year:Number = new Date().fullYear;
		
		[Bindable]
		public var month:Number = new Date().month;
		
		[Bindable]
		public var day:Number = new Date().date;
		
		private var _week:String;

		[Bindable]
		public function get week():String
		{
			return "星期"+weeks.getItemAt(selectedDate.day);
		}
		
		private var _selectedDate:Date = new Date();
		
		private var selectedDatePropertyChanged:Boolean=false;

		[Bindable]
		public function get selectedDate():Date
		{
			return _selectedDate;
		}

		public function set selectedDate(value:Date):void
		{
			_selectedDate = value;
			this.year = selectedDate.fullYear;
			this.month = selectedDate.month;
			this.day = selectedDate.date;
			timePicker.selectedDate = selectedDate;
			invalidateSelectedDateProperties();
		}
		
		public function invalidateSelectedDateProperties():void
		{
			if (selectedDatePropertyChanged)
				return;
			selectedDatePropertyChanged=true;
			invalidateProperties();
		}
		
		protected function commitSelectedDateProperties():void
		{
			/*this.year = selectedDate.fullYear;
			this.month = selectedDate.month;
			this.day = selectedDate.date;
			timePicker.selectedDate = selectedDate;*/
		}
		
		public function updateYearMonth():void
		{
			//更新年份选中按钮
			for each (var yb:YearOrMonthToggleButton in yearButtons) {
				yb.selected = (yb.year==year);
			}
			//更新月份选中按钮
			for each (var mb:YearOrMonthToggleButton in monthButtons) {
				mb.selected = (mb.month==month);
			}
			drawDays();
		}
		
		private function updateDay():void
		{
			for each (var db:DayButton in daysButtons) {
				db.selected = (db.date.fullYear==selectedDate.fullYear && db.date.month==selectedDate.month && db.date.date==selectedDate.date);
			}
		}
		

		
		public function DatetimePicker()
		{
			super();
			var y:int = 1900;
			for (var i:int=0; i<20; i++) {
				var ys:ArrayCollection = new ArrayCollection();
				for (var j:int=0; j<12; j++) {
					ys.addItem(y++);
				}
				years.addItem(ys);
			}
		}
		
		
		private function prevYear():void
		{
			this.year--;
			updateYearMonth();
		}
		
		private function prevMonth():void
		{
			this.month--;
			if(this.month<0){
				this.year--;
				this.month = 11;
			}
			updateYearMonth();
		}
		
		private function nextYear():void
		{
			this.year++;
			updateYearMonth();
		}
		
		private function nextMonth():void
		{
			this.month ++;
			if(this.month>11){
				this.year ++;
				this.month = 0;
			}
			updateYearMonth();
		}
		
		private function prevPageYears():void
		{
			yearIndex--;
			createYearButtons();
		}
		
		private function nextPageYears():void
		{
			yearIndex++;
			createYearButtons();
		}
		
		[Bindable]
		public var pageYears:ArrayCollection;
		
		private var yearButtons:Array;
		private function createYearButtons():void
		{
			if (yearsTileGroup) {
				yearsTileGroup.removeAllElements();
				yearButtons = new Array();
				pageYears = years.getItemAt(yearIndex) as ArrayCollection;
				for (var i:int=0; i<12; i++) {
					var btn:YearOrMonthToggleButton = new YearOrMonthToggleButton();
					btn.label = pageYears.getItemAt(i).toString();
					btn.year = new Number(pageYears.getItemAt(i));
					btn.selected = (btn.year==year);
					btn.addEventListener(Event.CHANGE, yearChangeHandler);
					yearsTileGroup.addElement(btn);
					yearButtons.push(btn);
				}
			}
		}
		
		private function yearChangeHandler(event:Event):void
		{
			var btn:YearOrMonthToggleButton = event.target as YearOrMonthToggleButton;
			this.year = btn.year;
			updateYearMonth();
			state = STATE_MONTHS;
		}
		
		private var monthButtons:Array = [];
		private function createMonthButtons():void
		{
			for (var i:int=0; i<12; i++) {
				var btn:YearOrMonthToggleButton = new YearOrMonthToggleButton();
				btn.label = months.getItemAt(i) as String;
				btn.month = i;
				btn.selected = (btn.month==month);
				btn.addEventListener(Event.CHANGE, monthChangeHandler);
				monthsTileGroup.addElement(btn);
				monthButtons.push(btn);
			}
		}
		
		private function monthChangeHandler(event:Event):void
		{
			var btn:YearOrMonthToggleButton = event.target as YearOrMonthToggleButton;
			this.month = btn.month;
			updateYearMonth();
			state = STATE_DAYS;
		}
		
		private var daysButtons:Array;
		private function drawDays():void
		{
			daysButtons = new Array();
			daysTileGroup.removeAllElements();
			var fd:Number = new Date(this.year, this.month, 1).day;
			var ld:Number = getDays(this.month);
			var day:int = (fd==0)?-7:-fd;
			for (var i:int=0; i<6; i++) {
				for (var j:int=0; j<7; j++) {
					var db:DayButton = new DayButton();
					var dt:Date = new Date(this.year, this.month, 1);
					dt.date += day;
					db.date = dt;
					db.selected = (db.date.fullYear==selectedDate.fullYear && db.date.month==selectedDate.month && db.date.date==selectedDate.date);
					if (day<0 || day>=ld) {
						db.notInCurrentMonth = true;
						db.addEventListener(Event.CHANGE, notInCurrentMonthChangeHandler);
					} else {
						db.addEventListener(Event.CHANGE, dayButtonChangeHandler);
					}
					daysTileGroup.addElement(db);
					daysButtons.push(db);
					day ++;
				}
			}
		}
		
		private function notInCurrentMonthChangeHandler(event:Event):void
		{
			var btn:DayButton = event.target as DayButton;
			var dt:Date = btn.date;
			dt.hours = timePicker.selectedDate.hours;
			dt.minutes = timePicker.selectedDate.minutes;
			dt.seconds = timePicker.selectedDate.seconds;
			selectedDate = dt;
			commitSelectedDateProperties();
			updateYearMonth();
		}
		
		private function dayButtonChangeHandler(event:Event):void
		{
			var btn:DayButton = event.target as DayButton;
			var dt:Date = btn.date;
			dt.hours = timePicker.selectedDate.hours;
			dt.minutes = timePicker.selectedDate.minutes;
			dt.seconds = timePicker.selectedDate.seconds;
			selectedDate = dt;
			commitSelectedDateProperties();
			updateDay();
		}
		
		
		override protected function getCurrentSkinState():String
		{
			return this.state;
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			if (selectedDatePropertyChanged) {
				commitSelectedDateProperties();
				selectedDatePropertyChanged=false;
			}
		}
		
		override protected function partAdded(partName:String, instance:Object):void
		{
			super.partAdded(partName, instance);
			
			if (instance == yearMonthButton) {
				yearMonthButton.addEventListener(MouseEvent.CLICK, function(event:MouseEvent):void{
					state = (state==STATE_DAYS)?STATE_MONTHS:STATE_YEARS;
				});
			} else if (instance == prevMonthButton) {
				prevMonthButton.addEventListener(MouseEvent.CLICK, function(event:MouseEvent):void{
					if (state==STATE_DAYS)
						prevMonth();
					else if (state==STATE_MONTHS)
						prevYear();
				});
			} else if (instance == nextMonthButton) {
				nextMonthButton.addEventListener(MouseEvent.CLICK, function(event:MouseEvent):void{
					if (state==STATE_DAYS)
						nextMonth();
					else if (state==STATE_MONTHS)
						nextYear();
				});
			} else if (instance == monthsTileGroup) {
				createMonthButtons();
			} else if (instance == yearsTileGroup) {
				createYearButtons();
			} else if (instance == prevPageYearsButton) {
				prevPageYearsButton.addEventListener(MouseEvent.CLICK, function(event:MouseEvent):void{
					prevPageYears();
				});
			} else if (instance == nextPageYearsButton) {
				nextPageYearsButton.addEventListener(MouseEvent.CLICK, function(event:MouseEvent):void{
					nextPageYears();
				});
			} else if (instance == daysTileGroup) {
				drawDays();
			} else if (instance == todayButton) {
				todayButton.addEventListener(MouseEvent.CLICK, function(event:MouseEvent):void{
					var dt:Date = new Date();
					dt.hours = timePicker.selectedDate.hours;
					dt.minutes = timePicker.selectedDate.minutes;
					dt.seconds = timePicker.selectedDate.seconds;
					selectedDate = dt;
					commitSelectedDateProperties();
					updateYearMonth();
				});
			} else if (instance == confirmButton) {
				confirmButton.addEventListener(MouseEvent.CLICK, function(event:MouseEvent):void{
					var dt:Date = new Date();
					dt.fullYear = selectedDate.fullYear;
					dt.month = selectedDate.month;
					dt.date = selectedDate.date;
					dt.hours = timePicker.selectedDate.hours;
					dt.minutes = timePicker.selectedDate.minutes;
					dt.seconds = timePicker.selectedDate.seconds;
					/*var df:DateFormatter = new DateFormatter();
					df.formatString = dateField.formatString;
					dateField.text = df.format(dt);*/
					dateField.selectedDate = dt;
					dateField.popUpAnchor.displayPopUp = false;
				});
			} else if (instance == clearButton) {
				clearButton.addEventListener(MouseEvent.CLICK, function(event:MouseEvent):void{
					dateField.selectedDate = null;
					dateField.text = "";
				});
			}
			
		}
	}
}