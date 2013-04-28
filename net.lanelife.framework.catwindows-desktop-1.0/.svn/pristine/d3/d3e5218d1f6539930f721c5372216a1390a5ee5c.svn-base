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
	import net.lanelife.framework.catwindows.components.Window;
	import net.lanelife.framework.catwindows.events.WindowEvent;
	import net.lanelife.framework.catwindows.managers.WindowManager;
	import net.lanelife.framework.os.core.ScreenContext;
	import net.lanelife.framework.os.core.SystemContext;
	
	public class DesktopWindow extends Window
	{
		
		/**
		 * 任务栏按钮 
		 */
		public var taskbarButton:TaskbarButton;
		
		private var _taskbarButtonLabel:String = "";
		
		/**
		 * 任务栏按钮文本。
		 * 如果此文本为空，则修改title将同时修改任务栏按钮文本。
		 * 如果此文本不为空，则修改title将不会同时修改任务栏按钮文本。
		 * @return 
		 * 
		 */
		public function get taskbarButtonLabel():String
		{
			return _taskbarButtonLabel;
		}
		public function set taskbarButtonLabel(value:String):void
		{
			_taskbarButtonLabel = value;
			taskbarButton.label = value;
		}
		
		
		private var _taskbarButtonVisible:Boolean = true;
		
		public function get taskbarButtonVisible():Boolean
		{
			return taskbarButton.visible;
		}
		
		public function set taskbarButtonVisible(value:Boolean):void
		{
			_taskbarButtonVisible = value;
			if(value)
				taskbarButton.show(this.screenContext.taskbarButtonContainer);
			else
				taskbarButton.hide();
		}
		
		override public function set title(value:String):void 
		{
			super.title = value;
			
			if (taskbarButtonLabel=="")
				taskbarButton.label = title;
		}
		
		override public function set icon(value:Object):void
		{
			super.icon = value;
			
			if (icon!=null)
			{
				taskbarButton.icon = icon;
			}
		}
		
		
		
		
		
		/**
		 * 桌面窗口 
		 * @param title 窗口标题
		 * @param owner 父窗口
		 * 
		 */
		public function DesktopWindow(title:String=null, owner:Window=null)
		{
			
			this.taskbarButton = new TaskbarButton(this);
			this.addEventListener(WindowEvent.WINDOW_ACTIVATED, window_activeHandler);
			this.addEventListener(WindowEvent.WINDOW_DEACTIVATED, window_deactiveHandler);
			
			super(title, owner);
			
		}
		
		
		
		
		/**
		 * 屏幕控制器，窗口拥有相同的屏幕控制器，代表窗口受同一个的窗口管理器管理，并在同一个窗口容器中显示。
		 */
		private var _screenContext:ScreenContext;

		public function get screenContext():ScreenContext
		{
			return _screenContext;
		}

		public function set screenContext(value:ScreenContext):void
		{
			_screenContext = value;
		}

		
		/**
		 * 调用此方法前需设置screenContext或者设置ownerWindow属性，否则窗口将创建到当前显示屏幕。
		 * 如果您要保证应用的所有窗口都位于同个屏幕，您必须让应用的窗口拥有相同的屏幕控制器（ScreenContext）。
		 * 如果没有指定ScreenContext，则先从父窗口中获取ScreenContext，如果父窗口中没有ScreenContext则取系统当前的ScreenContext。
		 * @param render
		 * @param manager
		 * 
		 */		
		override public function show(render:*=null, manager:WindowManager=null):void
		{
			//屏幕控制器，如果没有指定ScreenContext，则先从父窗口中获取ScreenContext，如果父窗口中没有ScreenContext则取系统当前的ScreenContext
			if (this.screenContext==null) {
				if (ownerWindow!=null)
					this.screenContext = DesktopWindow(ownerWindow).screenContext;
				else
					this.screenContext = SystemContext.instance.currentScreenContext;
			}
			
			super.show(this.screenContext.windowsContainer, WindowManager.getWindowManager(screenContext.windowManagerId));
			
			if (taskbarButtonVisible) {
				this.taskbarButton.show(this.screenContext.taskbarButtonContainer);
			}
			
			
		}
		
		
		
		/**
		 * 销毁窗口，同时销毁任务栏按钮。
		 * 
		 */		
		override protected function destroy():void
		{
			if (this.manager)
			{
				this.taskbarButton.destroy();
			}
			super.destroy();
		}
		
		
		/**
		 * 当窗口变为活动窗口时，将任务栏按钮也设为活动状态。 
		 * @param event
		 * 
		 */
		private function window_activeHandler(event:WindowEvent):void
		{
			this.taskbarButton.activated = true;
		}
		
		/**
		 * 当窗口为停用状态时，任务栏按钮也为停用状态。 
		 * @param event
		 * 
		 */
		private function window_deactiveHandler(event:WindowEvent):void
		{
			this.taskbarButton.activated = false;
		}
		
		override protected function partAdded(partName:String, instance:Object):void
		{
			super.partAdded(partName, instance);
			
			if (instance == iconDisplay)
			{
				if (icon!=null)
				{
					taskbarButton.icon = icon;
				}
			}
		}
		
		
		
	}
}