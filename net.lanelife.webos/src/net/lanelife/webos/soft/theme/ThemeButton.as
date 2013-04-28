package net.lanelife.webos.soft.theme
{
	import spark.components.Button;
	
	public class ThemeButton extends Button
	{
		
		[Bindable]
		public var themename:String;
		
		[Bindable]
		public var pic:Object;
		
		[Bindable]
		public var swf:String;
		
		[Bindable]
		public var background:String;
		
		[Bindable]
		public var chromeColor:String;
		
		public function ThemeButton()
		{
			super();
			
		}
		
	}
}