/*

This file is part of LANE WEBOS

Copyright (c) 2011 LANE WEBOS

Contact:  http://www.lanelife.org/contact

GNU General Public License Usage
This file may be used under the terms of the GNU General Public License version 2.0 as published by the Free Software Foundation and appearing in the file LICENSE included in the packaging of this file.  Please review the following information to ensure the GNU General Public License version 2.0 requirements will be met: http://www.gnu.org/copyleft/gpl.html.

If you are unsure which license is appropriate for your use, please contact the sales department at http://www.lanelife.org/contact.

*/
package net.lanelife.framework.os.skins.vista
{
	import flash.filters.GlowFilter;
	
	import mx.skins.halo.HaloBorder;

	
	public class MenuBorderSkin extends HaloBorder
	{
		public function MenuBorderSkin()
		{
			super();
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth,unscaledHeight);
			var glow:GlowFilter = new GlowFilter();
			glow.blurX = 5;
			glow.blurY = 5;
			glow.color = 0x000000;
			glow.alpha = 0.25;
			filters = [glow];
			
			var w:Number = this.width;
			var h:Number = this.height;
			
			graphics.lineStyle(1,0x666666);
			graphics.beginFill(0xfefefe);
			graphics.drawRect(-1,-1,w+1,h+1);
			graphics.endFill();
			
			graphics.lineStyle(1,0xe8edee);
			graphics.beginFill(0xe8edee);
			graphics.drawRect(1,1,25,h-3);
			graphics.endFill();
			
		} 

	}
}