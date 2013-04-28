package net.lanelife.framework.catwindows.components
{
	import flash.geom.Point;
	import spark.components.SkinnableContainer;
	import net.lanelife.framework.catwindows.core.SystemVariables;
	import net.lanelife.framework.catwindows.events.TaskbarButtonEvent;
	import net.lanelife.framework.catwindows.events.WindowEventDispatcher;

	public class DesktopWindow extends Window
	{
		
		/**
		 * 任务栏按钮 
		 */
		public var taskbarButton:TaskbarButton;
		
		
		public function DesktopWindow(title:String=null, owner:Window=null)
		{
			this.taskbarButton = new TaskbarButton(this);
			super(title, owner);
		}
		
		
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
				taskbarButton.show();
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
			if(this.skin && this.skin.hasOwnProperty("iconDisplay"))
			{
				if (icon!=null)
				{
					taskbarButton.icon = icon;
				}
			}
		}
		
		override public function show():void
		{
			if (!created)
			{
				WindowEventDispatcher.getInstance().dispatchEvent(
					new TaskbarButtonEvent(TaskbarButtonEvent.TASKBAR_BUTTON_CREATE+SystemVariables.currentDesktopScreenIndex, taskbarButton)
				);
			}
			
			super.show();
		}
		override protected function destroy():void
		{
			if (this.manager)
			{
				WindowEventDispatcher.getInstance().dispatchEvent(
					new TaskbarButtonEvent(TaskbarButtonEvent.TASKBAR_BUTTON_DESTROY+SystemVariables.currentDesktopScreenIndex, taskbarButton)
				);
			}
			super.destroy();
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