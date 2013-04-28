package net.lanelife.framework.catwindows.events
{
	import flash.events.Event;
	
	public class SystemLoginEvent extends Event
	{
		
		public static const LOGIN_SUCCESS:String = "systemLoginSuccess";
		
		public function SystemLoginEvent(type:String)
		{
			super(type);
		}
	}
}