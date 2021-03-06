/*

This file is part of LANE WEBOS

Copyright (c) 2011 LANE WEBOS

Contact:  http://www.lanelife.org/contact

GNU General Public License Usage
This file may be used under the terms of the GNU General Public License version 2.0 as published by the Free Software Foundation and appearing in the file LICENSE included in the packaging of this file.  Please review the following information to ensure the GNU General Public License version 2.0 requirements will be met: http://www.gnu.org/copyleft/gpl.html.

If you are unsure which license is appropriate for your use, please contact the sales department at http://www.lanelife.org/contact.

*/
package net.lanelife.framework.utils
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.geom.Rectangle;
	
	import mx.core.FlexGlobals;
	import mx.effects.Parallel;
	import mx.events.SandboxMouseEvent;
	import mx.managers.PopUpManager;
	
	import spark.components.Button;
	import spark.components.Group;
	import spark.components.Label;
	import spark.components.SkinnableContainer;
	import spark.effects.Fade;
	import spark.effects.Scale;
	
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
			
			var eff1:Scale = new Scale();
			eff1.scaleXFrom = 0.95;
			eff1.scaleXTo = 1;
			eff1.scaleYFrom = 0.95;
			eff1.scaleYTo = 1;
			eff1.autoCenterTransform = true;
			var eff2:Fade = new Fade();
			eff2.alphaFrom = 0;
			eff2.alphaTo = 1;
			var p1:Parallel = new Parallel();
			p1.addChild(eff1);
			p1.addChild(eff2);
			this.setStyle("creationCompleteEffect", p1);
			
			var eff3:Scale = new Scale();
			eff3.scaleXFrom = 1;
			eff3.scaleXTo = 0.95;
			eff3.scaleYFrom = 1;
			eff3.scaleYTo = 0.95;
			eff3.autoCenterTransform = true;
			var eff4:Fade = new Fade();
			eff4.alphaFrom = 1;
			eff4.alphaTo = 0;
			var p2:Parallel = new Parallel();
			p2.addChild(eff3);
			p2.addChild(eff4);
			this.setStyle("removedEffect", p2);
			
			
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
			//progressGroup.percentWidth = 30;
			messageLabel.text = error;
			closeButton.visible = true;
			progressGroup.visible = false;
			percentLabel.visible = false;
			//bytesLabel.visible = false;
			//ticketLabel.visible = false;
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
		
		override protected function partAdded(partName:String, instance:Object):void
		{
			
			super.partAdded(partName, instance);
			
			if (instance == progressGroup)
			{
				progressGroup.percentWidth = 0;
			}
		}
		
	}
}