package net.lanelife.framework.catwindows.events
{
	import flash.events.Event;
	
	public class DesktopContextEvent extends Event
	{
		
		public static const REPLACE_BACKGROUND:String = "replaceBackground";
		
		public function DesktopContextEvent(type:String)
		{
			super(type);
		}
	}
}