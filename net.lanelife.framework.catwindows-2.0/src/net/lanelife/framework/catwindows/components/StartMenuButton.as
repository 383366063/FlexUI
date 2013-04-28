package net.lanelife.framework.catwindows.components
{
	import spark.components.Button;
	
	public class StartMenuButton extends Button
	{
		
		[Bindable]
		public var moduleUrl:String;
		
		public function StartMenuButton()
		{
			super();
		}
	}
}