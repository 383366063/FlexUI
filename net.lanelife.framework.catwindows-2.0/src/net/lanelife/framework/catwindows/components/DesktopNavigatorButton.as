package net.lanelife.framework.catwindows.components
{
	import spark.components.Button;
	
	public class DesktopNavigatorButton extends Button
	{
		
		[SkinState("selected")]
		
		public function DesktopNavigatorButton()
		{
			super();
		}
		
		private var _selected:Boolean;

		public function get selected():Boolean
		{
			return _selected;
		}

		public function set selected(value:Boolean):void
		{
			_selected = value;
			invalidateSkinState();
		}
		
		override protected function getCurrentSkinState():String
		{
			if (selected)
				return "selected";
			return super.getCurrentSkinState();
		}

	}
}