package net.lanelife.framework.catwindows.skins.vista
{
	import mx.skins.ProgrammaticSkin;
	
	public class MenuSeparatorSkin extends ProgrammaticSkin
	{
		public function MenuSeparatorSkin()
		{
			super();
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth,unscaledHeight);
			var w:Number=this.width;
			var h:Number=1;
			
			graphics.lineStyle(1,0xe8edee);
			graphics.moveTo(24,h);
			graphics.lineTo(w,h)
			graphics.endFill(); 
		}

		
	}
}