package net.lanelife.framework.catwindows.utils
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.geom.Rectangle;
	
	import mx.core.FlexGlobals;
	import mx.events.SandboxMouseEvent;
	import mx.managers.PopUpManager;
	
	import spark.components.Button;
	import spark.components.Group;
	import spark.components.Label;
	import spark.components.SkinnableContainer;
	
	public class ProgressBar extends SkinnableContainer
	{
		
		[SkinPart(required="true")]
		public var messageLabel:Label;
		
		[SkinPart(required="true")]
		public var percentLabel:Label;
		
		[SkinPart(required="true")]
		public var bytesLabel:Label;
		
		[SkinPart(required="true")]
		public var ticketLabel:Label;
		
		[SkinPart(required="true")]
		public var progressGroup:Group;
		
		[SkinPart(required="true")]
		public var closeButton:Button;
		
		private var _total:Number = 1;

		public function get total():Number
		{
			return _total;
		}

		public function set total(value:Number):void
		{
			_total = value;
			setTicket();
		}

		private var _current:Number = 1;

		public function get current():Number
		{
			return _current;
		}

		public function set current(value:Number):void
		{
			_current = value;
			setTicket();
		}
		
		
		public function ProgressBar()
		{
			super();
			PopUpManager.addPopUp(this, FlexGlobals.topLevelApplication.parent);
			PopUpManager.centerPopUp(this);
			
			this.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			
		}
		
		public function setTicket():void
		{
			ticketLabel.text = current+"/"+total;
		}
		
		
		private var offsetX:Number;
		private var offsetY:Number;
		protected function mouseDownHandler(event:MouseEvent):void
		{
			offsetX = event.stageX - x;
			offsetY = event.stageY - y;
			var sbRoot:DisplayObject = systemManager.getSandboxRoot();
			sbRoot.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler, true);
			sbRoot.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler, true);
			sbRoot.addEventListener(SandboxMouseEvent.MOUSE_UP_SOMEWHERE, mouseUpHandler)
			systemManager.deployMouseShields(true); 
		}
		protected function mouseMoveHandler(event:MouseEvent):void
		{
			var afterBounds:Rectangle = new Rectangle(Math.round(event.stageX - this.offsetX),Math.round(event.stageY - this.offsetY),width,height);
			this.x = afterBounds.x;
			this.y = afterBounds.y;
		}
		protected function mouseUpHandler(event:Event):void
		{
			var sbRoot:DisplayObject = systemManager.getSandboxRoot();
			sbRoot.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler, true);
			sbRoot.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler, true);
			sbRoot.removeEventListener(SandboxMouseEvent.MOUSE_UP_SOMEWHERE, mouseUpHandler);
			offsetX = NaN;
			offsetY = NaN;
		}
		
		
		public function progress(event:ProgressEvent, message:String):void
		{
			var per:uint = Math.ceil(event.bytesLoaded/event.bytesTotal*100); 
			percentLabel.text = per.toString() + "%";
			progressGroup.percentWidth = per;
			var bl:String = size2str(event.bytesLoaded);
			var bt:String = size2str(event.bytesTotal);
			bytesLabel.text = bl+" / "+bt;
			messageLabel.text = message;

		}
		
		public function showError(error:String):void
		{
			messageLabel.text = error;
			closeButton.visible = true;
			progressGroup.visible = false;
			closeButton.addEventListener(MouseEvent.CLICK, function():void{
				close();
			});
		}
		
		public function close():void
		{
			PopUpManager.removePopUp(this);
		}
		
		private function size2str(size:Number):String
		{
			var m:Array = [ " Bytes", " KB", " MB" ];
			for(var i:int=0,n:int=m.length; i<n && size>=1024; i++)
			{
				size /= 1024;
			}
			return (i>0 ? size.toFixed(i) : int(size) ) + m[i];
		}
		
		
	}
}