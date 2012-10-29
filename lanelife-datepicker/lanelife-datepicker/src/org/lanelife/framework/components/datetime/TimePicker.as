package org.lanelife.framework.components.datetime
{
	import flash.events.FocusEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import mx.managers.IFocusManagerComponent;
	
	import spark.components.Group;
	import spark.components.SkinnableContainer;
	import spark.components.TextInput;
	import spark.events.TextOperationEvent;
	
	public class TimePicker extends SkinnableContainer
	{
		
		[SkinPart(required="true")]
		public var hourDisplay:TextInput;
		[SkinPart(required="true")]
		public var minuteDisplay:TextInput;
		[SkinPart(required="true")]
		public var secondDisplay:TextInput;
		
		[SkinPart(required="true")]
		public var hourPointer:Group;
		[SkinPart(required="true")]
		public var minutePointer:Group;
		[SkinPart(required="true")]
		public var secondPointer:Group;
		
		
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
			setHourText();
			setMinuteText()
			setSecondText();
			updatePointer();
		}
		
		private function updatePointer():void
		{
			if (hourPointer)
				hourPointer.rotation = (selectedDate.hours>12?selectedDate.hours-12:selectedDate.hours)*30+(selectedDate.minutes/2);
			if (minutePointer)
				minutePointer.rotation = selectedDate.minutes*6+(selectedDate.seconds/10);
			if (secondPointer)
				secondPointer.rotation = selectedDate.seconds*6;
		}
		
		private function setHourText():void
		{
			if (hourDisplay)
				hourDisplay.text = selectedDate.hours<10?"0"+selectedDate.hours:selectedDate.hours.toString();
		}
		private function setMinuteText():void
		{
			if (minuteDisplay)
				minuteDisplay.text = selectedDate.minutes<10?"0"+selectedDate.minutes:selectedDate.minutes.toString();
		}
		private function setSecondText():void
		{
			if (secondDisplay)
				secondDisplay.text = selectedDate.seconds<10?"0"+selectedDate.seconds:selectedDate.seconds.toString();
		}

		private var timer:Timer = new Timer(1000,0);

		
		public function TimePicker()
		{
			super();
			timer.addEventListener(TimerEvent.TIMER, function(event:TimerEvent):void{
				selectedDate = new Date();
			});
		}
		
		public function start():void
		{
			timer.reset();
			timer.stop();
			timer.start();
		}
		
		public function stop():void
		{
			timer.stop();
		}
		
		
		override protected function partAdded(partName:String, instance:Object):void
		{
			super.partAdded(partName, instance);
			
			if (instance == hourDisplay) {
				hourDisplay.restrict = "0-9";
				hourDisplay.maxChars = 2;
				hourDisplay.addEventListener(FocusEvent.FOCUS_IN, function(event:FocusEvent):void{
					hourDisplay.selectAll();
				});
				hourDisplay.addEventListener(FocusEvent.FOCUS_OUT, function(event:FocusEvent):void{
					setHourText();
				});
				hourDisplay.addEventListener(TextOperationEvent.CHANGE, function(event:TextOperationEvent):void{
					var h:Number = new Number(hourDisplay.text);
					if (isNaN(h) || h>23) {
						h = selectedDate.hours;
						hourDisplay.text = h.toString();
					}
					selectedDate.hours = h;
					updatePointer();
				});
				setHourText();
			} else if (instance == minuteDisplay) {
				minuteDisplay.restrict = "0-9";
				minuteDisplay.maxChars = 2;
				minuteDisplay.addEventListener(FocusEvent.FOCUS_IN, function(event:FocusEvent):void{
					minuteDisplay.selectAll();
				});
				minuteDisplay.addEventListener(FocusEvent.FOCUS_OUT, function(event:FocusEvent):void{
					setMinuteText();
				});
				minuteDisplay.addEventListener(TextOperationEvent.CHANGE, function(event:TextOperationEvent):void{
					var m:Number = new Number(minuteDisplay.text);
					if (isNaN(m) || m>59) {
						m = selectedDate.minutes;
						minuteDisplay.text = m.toString();
					}
					selectedDate.minutes = m;
					updatePointer();
				});
				setMinuteText();
			} else if (instance == secondDisplay) {
				secondDisplay.restrict = "0-9";
				secondDisplay.maxChars = 2;
				secondDisplay.addEventListener(FocusEvent.FOCUS_IN, function(event:FocusEvent):void{
					secondDisplay.selectAll();
				});
				secondDisplay.addEventListener(FocusEvent.FOCUS_OUT, function(event:FocusEvent):void{
					setSecondText();
				});
				secondDisplay.addEventListener(TextOperationEvent.CHANGE, function(event:TextOperationEvent):void{
					var s:Number = new Number(secondDisplay.text);
					if (isNaN(s) || s>59) {
						s = selectedDate.seconds;
						secondDisplay.text = s.toString();
					}
					selectedDate.seconds = s;
					updatePointer();
				});
				setSecondText();
			} else if (instance == hourPointer) {
				updatePointer();
			} else if (instance == minutePointer) {
				updatePointer();
			} else if (instance == secondPointer) {
				updatePointer();
			}
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			if (selectedDatePropertyChanged)
			{
				commitSelectedDateProperties();
				selectedDatePropertyChanged=false;
			}
		}
	}
}