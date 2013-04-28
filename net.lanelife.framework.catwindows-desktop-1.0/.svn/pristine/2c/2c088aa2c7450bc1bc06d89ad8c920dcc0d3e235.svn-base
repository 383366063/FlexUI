/*

This file is part of LANE WEBOS

Copyright (c) 2011 LANE WEBOS

Contact:  http://www.lanelife.org/contact

GNU General Public License Usage
This file may be used under the terms of the GNU General Public License version 2.0 as published by the Free Software Foundation and appearing in the file LICENSE included in the packaging of this file.  Please review the following information to ensure the GNU General Public License version 2.0 requirements will be met: http://www.gnu.org/copyleft/gpl.html.

If you are unsure which license is appropriate for your use, please contact the sales department at http://www.lanelife.org/contact.

*/
package net.lanelife.framework.catwindows.desktop.components
{
	import flash.events.MouseEvent;
	
	import net.lanelife.framework.catwindows.components.Window;
	
	import spark.components.Button;
	import spark.components.Image;
	import spark.effects.Scale;
	
	/**
	 * 任务栏按钮类 
	 * @author Lane
	 * 
	 */
	public class TaskbarButton extends Button
	{
		/**
		 * 活动状态
		 */		
		[SkinState("activated")]
		
		/**
		 * 闪烁状态 
		 */
		[SkinState("flashes")]
		
		
		[SkinPart(required="false")]
		/**
		 * 定义任务栏图标外观的外观部件。 
		 */
		public var iconImage:Image;
		
		
		[Bindable]
		public var window:Window;
		
		
		/**
		 * 任务栏按钮是否已创建 
		 */
		protected var created:Boolean = false;
		
		
		
		public function TaskbarButton(window:Window)
		{
			super();
			this.window = window;
			this.addEventListener(MouseEvent.CLICK, taskbarButton_clickHandler);
			
			var showEffect:Scale = new Scale();
			showEffect.scaleXFrom = 0;
			showEffect.scaleXTo = 1;
			showEffect.duration = 400;
			showEffect.disableLayout = true;
			this.setStyle("creationCompleteEffect", showEffect);
			
			var hideEffect:Scale = new Scale();
			hideEffect.scaleXFrom = 1;
			hideEffect.scaleXTo = 0;
			hideEffect.duration = 400;
			hideEffect.disableLayout = true;
			this.setStyle("removedEffect", hideEffect);
			
		}
		
		
		protected function taskbarButton_clickHandler(event:MouseEvent):void
		{
			if (window==window.manager.front || window.disabled)
			{
				//循环判断该窗口的子窗口是否为焦点窗口，是则隐藏该窗口，否则显示该窗口
				if (window.disabled)
				{
					var flag:Boolean = false;
					for (var i:Number=0; i<window.ownedWindows.length; i++)
					{
						if (window.ownedWindows[i]==window.manager.front)
						{
							flag = true;
						}
					}
					
					if (flag)
						window.hide();
					else
					{
						window.show();
					}
				}
				else
				{
					window.hide(); //如果该窗口是焦点窗口则隐藏
				}
			}
			else
			{
				window.show(); //如果该窗口非活动窗口则将该窗口设置为活动窗口
			}
		}
		
		
		public var render:*;
		/**
		 * 显示任务栏按钮 
		 * 
		 */
		public function show(render:*):void
		{
			this.render = render;
			if (created)
			{
				this.visible = true;
				this.includeInLayout = true;
			}
			else if (render!=null)
			{
				created = true;
				render.addElement(this);
			}
		}
		
		/**
		 * 隐藏任务栏按钮 
		 * 
		 */
		public function hide():void
		{
			this.visible = false;
			this.includeInLayout = false;
		}
		
		
		public function destroy():void
		{
			if (this.render)
				this.render.removeElement(this);
		}
		
		
		
		/**
		 * 窗口为活动状态时，任务栏按钮也是活动状态 。
		 */
		private var _activated:Boolean;
		
		public function get activated():Boolean
		{
			return _activated;
		}
		
		public function set activated(value:Boolean):void
		{
			_activated = value;
			invalidateSkinState();
		}
		
		/**
		 * 任务栏按钮是否为闪烁状态 
		 */
		private var _flashes:Boolean;
		
		public function get flashes():Boolean
		{
			return _flashes;
		}
		
		public function set flashes(value:Boolean):void
		{
			_flashes = value;
			invalidateSkinState();
		}
		
		/**
		 * 任务栏图标 
		 */
		private var _icon:Object;
		
		public function get icon():Object
		{
			return _icon;
		}
		
		public function set icon(value:Object):void
		{
			_icon = value;
			if (iconImage)
			{
				if (icon!=null)
				{
					iconImage.source = icon;
					iconImage.visible = true;
					iconImage.includeInLayout = true;
					iconImage.smooth = true;
				}
				else
				{
					iconImage.visible = false;
					iconImage.includeInLayout = false;
				}
			}
		}
		
		override protected function partAdded(partName:String, instance:Object):void
		{
			super.partAdded(partName, instance);
			if (instance == iconImage)
			{
				if (icon!=null)
				{
					iconImage.source = icon;
					iconImage.visible = true;
					iconImage.includeInLayout = true;
					iconImage.smooth = true;
				}
				else
				{
					iconImage.visible = false;
					iconImage.includeInLayout = false;
				}
			}
		}
		
		
		override protected function getCurrentSkinState():String
		{
			if (activated)
				return "activated";
			if (flashes)
				return "flashes";
			return super.getCurrentSkinState();
		}
		
		
	}
}