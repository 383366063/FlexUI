package net.lanelife.webos.soft.theme
{
	import spark.components.Button;
	
	public class ColorButton extends Button
	{
		
		[Bindable]
		public var chromeColor:uint;
		
		public function ColorButton()
		{
			super();
		}
	}
}