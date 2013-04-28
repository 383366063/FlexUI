package net.lanelife.framework.catwindows.events
{
	import flash.events.Event;
	
	import net.lanelife.framework.catwindows.components.TaskbarButton;
	
	
	public class TaskbarButtonEvent extends Event
	{
		public static const TASKBAR_BUTTON_CREATE:String = "taskbarButtonCreate";
		public static const TASKBAR_BUTTON_DESTROY:String = "taskbarButtonDestroy";
		
		public var taskbarButton:TaskbarButton;
		
		public function TaskbarButtonEvent(type:String, taskbarButton:TaskbarButton)
		{
			super(type);
			this.taskbarButton = taskbarButton;
		}
	}
}