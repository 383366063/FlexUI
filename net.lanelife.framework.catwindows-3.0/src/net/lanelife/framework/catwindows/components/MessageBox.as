/*

This file is part of LANE WEBOS

Copyright (c) 2011 LANE WEBOS

Contact:  http://www.lanelife.org/contact

GNU General Public License Usage
This file may be used under the terms of the GNU General Public License version 2.0 as published by the Free Software Foundation and appearing in the file LICENSE included in the packaging of this file.  Please review the following information to ensure the GNU General Public License version 2.0 requirements will be met: http://www.gnu.org/copyleft/gpl.html.

If you are unsure which license is appropriate for your use, please contact the sales department at http://www.lanelife.org/contact.

*/
package net.lanelife.framework.catwindows.components
{
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	
	import mx.core.FlexGlobals;
	import mx.events.CloseEvent;
	import mx.events.FlexEvent;
	import mx.graphics.SolidColor;
	
	import net.lanelife.framework.catwindows.events.WindowEvent;
	
	import spark.components.BorderContainer;
	import spark.components.Button;
	import spark.components.HGroup;
	import spark.components.Image;
	import spark.components.Label;

	/**
	 * 消息框类 
	 * @author Lane
	 * 
	 */
	public class MessageBox extends Window
	{
		public static const YES:uint = 0x0001;
		public static const NO:uint = 0x0002;
		public static const OK:uint = 0x0004;
		public static const CANCEL:uint= 0x0008;
		
		public static var yesLabel:String = "是";
		public static var noLabel:String = "否";
		public static var okLabel:String = "确定";
		public static var cancelLabel:String = "取消";
		
		public static var buttonHeight:Number = 22;
		public static var buttonWidth:Number = 65;
		public static var buttonAlign:String = "right";
		
		public var buttonFlags:uint = OK;
		public var defaultButtonFlag:uint = OK;
		[Bindable]
		public var iconObject:Object;
		public var text:String = "";
		
		public var defaultSelectedButton:Button;
		
		private var buttons:Array = [];
		private var defaultButtonChanged:Boolean = false;
		
		[SkinPart(required="false")]
		/**
		 * 位于  MessageBox 控件中文本左侧的图标的外观组件。
		 */
		public var messageBoxIconDisplay:Image;
		
		[SkinPart(required="false")]
		/**
		 * 在  Prompt 控件中显示的文本字符串的外观组件。
		 */
		public var textDisplay:Label;
		
		[SkinPart(required="false")]
		/**
		 * Prompt 控件中显示按钮的外观组件。
		 */
		public var buttonsGroup:HGroup;
		
		
		
		public static function show(text:String = "", 
									title:String = "",
									flags:uint = 0x4 /* Prompt.OK */, 
									parent:Window = null, 
									closeHandler:Function = null, 
									iconObject:Object = null, 
									defaultButtonFlag:uint = 0x4 /* Prompt.OK */):MessageBox
		{
			var messageBox:MessageBox = new MessageBox();
			if (flags & MessageBox.OK||
				flags & MessageBox.CANCEL ||
				flags & MessageBox.YES ||
				flags & MessageBox.NO)
			{
				messageBox.buttonFlags = flags;
			}
			
			if (defaultButtonFlag == MessageBox.OK ||
				defaultButtonFlag == MessageBox.CANCEL ||
				defaultButtonFlag == MessageBox.YES ||
				defaultButtonFlag == MessageBox.NO)
			{
				messageBox.defaultButtonFlag = defaultButtonFlag;
			}
			
			messageBox.createButtons();
			
			messageBox.text = text;
			messageBox.title = title;
			messageBox.iconObject = iconObject;
			
			messageBox.modal = true;
			messageBox.ownerWindow = parent;
			
			if(parent != null) {
				messageBox.icon = messageBox.ownerWindow.icon;
			}
			
			messageBox.minimizable = false;
			messageBox.maximizable = false;
			messageBox.resizable = false;
			
			if (closeHandler != null)
				messageBox.addEventListener(CloseEvent.CLOSE, closeHandler);
			
			
			messageBox.addEventListener(FlexEvent.CREATION_COMPLETE,static_creationCompleteHandler);
			
			messageBox.show();
			
			return messageBox;
		}
		
		private static function static_creationCompleteHandler(event:FlexEvent):void
		{
			var messageBox:MessageBox = MessageBox(event.target);
			messageBox.removeEventListener(FlexEvent.CREATION_COMPLETE, static_creationCompleteHandler);
			messageBox.setActualSize(messageBox.getExplicitOrMeasuredWidth(),messageBox.getExplicitOrMeasuredHeight());
			var p:Point = new Point();
			
			if(messageBox.ownerWindow != null) {
				p.x = (messageBox.ownerWindow.width - messageBox.getExplicitOrMeasuredWidth())/2 + messageBox.ownerWindow.x;
				p.y = (messageBox.ownerWindow.height - messageBox.getExplicitOrMeasuredHeight())/2 + messageBox.ownerWindow.y;
			} else {
				p.x = (FlexGlobals.topLevelApplication.width - messageBox.getExplicitOrMeasuredWidth())/2;
				p.y = (FlexGlobals.topLevelApplication.height - messageBox.getExplicitOrMeasuredHeight())/2;
				
				var mask:BorderContainer = new BorderContainer();
				mask.alpha = 0.1;
				mask.left = 0;
				mask.top = 0;
				mask.right = 0;
				mask.bottom = 0;
				var f:SolidColor = new SolidColor();
				f.color = 0x000000;
				mask.backgroundFill = f;
				FlexGlobals.topLevelApplication.addElement(mask);
				
				messageBox.addEventListener(WindowEvent.WINDOW_CLOSED, function(event:WindowEvent):void{
					FlexGlobals.topLevelApplication.removeElement(mask);
				});
				
			}
			
			messageBox.setPosition(p);
		}
		
		
		
		public function createButtons():void
		{
			var label:String;
			var button:Button;
			
			if (buttonFlags & MessageBox.OK)
			{
				label = String(MessageBox.okLabel);
				button = createButton(label, "OK");
				if (defaultButtonFlag == MessageBox.OK)
					defaultSelectedButton = button;
			}
			
			if (buttonFlags & MessageBox.YES)
			{
				label = String(MessageBox.yesLabel);
				button = createButton(label, "YES");
				if (defaultButtonFlag == MessageBox.YES)
					defaultSelectedButton = button;
			}
			
			if (buttonFlags & MessageBox.NO)
			{
				label = String(MessageBox.noLabel);
				button = createButton(label, "NO");
				if (defaultButtonFlag == MessageBox.NO)
					defaultSelectedButton = button;
			}
			
			if (buttonFlags & MessageBox.CANCEL)
			{
				label = String(MessageBox.cancelLabel);
				button = createButton(label, "CANCEL");
				if (defaultButtonFlag == MessageBox.CANCEL)
					defaultSelectedButton = button;
			}
			
			if (!defaultSelectedButton && buttons.length)
				defaultSelectedButton = buttons[0];
			
			if (defaultSelectedButton)
			{
				defaultButtonChanged = true;
				invalidateProperties();
			}
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			if (defaultButtonChanged && defaultSelectedButton)
			{
				defaultButtonChanged = false;
				defaultSelectedButton.setFocus();
			}
		}
		
		private function createButton(label:String, name:String):Button
		{
			var button:Button = new Button();
			button.label = label;
			button.name = name;
			button.addEventListener(MouseEvent.CLICK, clickHandler);
			button.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			button.setActualSize(MessageBox.buttonWidth, MessageBox.buttonHeight);
			buttons.push(button);
			return button;
		}
		
		override protected function bringToFront():void
		{
			super.bringToFront();
			if (defaultSelectedButton)
			{
				defaultSelectedButton.setFocus();
			}
		}
		
		private function clickHandler(event:MouseEvent):void
		{
			var name:String = Button(event.currentTarget).name;
			removePrompt(name);
		}
		
		override protected function keyDownHandler(event:KeyboardEvent):void
		{
			if (event.keyCode == Keyboard.ESCAPE)
			{
				if ((buttonFlags & MessageBox.CANCEL) || !(buttonFlags & MessageBox.NO))
					removePrompt("CANCEL");
				else if (buttonFlags & MessageBox.NO)
					removePrompt("NO");
			}
		}
		
		private function removePrompt(buttonPressed:String):void
		{
			var closeEvent:CloseEvent = new CloseEvent(CloseEvent.CLOSE);
			if (buttonPressed == "YES")
				closeEvent.detail = MessageBox.YES;
			else if (buttonPressed == "NO")
				closeEvent.detail = MessageBox.NO;
			else if (buttonPressed == "OK")
				closeEvent.detail = MessageBox.OK;
			else if (buttonPressed == "CANCEL")
				closeEvent.detail = MessageBox.CANCEL;
			dispatchEvent(closeEvent);
			close();
		}
		
		override protected function partAdded(partName:String, instance:Object):void
		{
			super.partAdded(partName, instance);
			if (instance == messageBoxIconDisplay)
			{
				messageBoxIconDisplay.source = iconObject;
			}
			else if(instance == textDisplay)
			{
				textDisplay.text = text;
			}
			else if(instance == buttonsGroup)
			{
				buttonsGroup.horizontalAlign = MessageBox.buttonAlign;
				for (var i:Number=0; i<buttons.length; i++)
				{
					buttonsGroup.addElement(buttons[i]);
				}
			}
		}
		
		public function MessageBox()
		{
			super();
		}
	}
}