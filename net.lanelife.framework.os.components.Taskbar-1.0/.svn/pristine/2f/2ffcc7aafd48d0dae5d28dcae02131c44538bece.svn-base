/*

This file is part of LANE WEBOS

Copyright (c) 2011 LANE WEBOS

Contact:  http://www.lanelife.org/contact

GNU General Public License Usage
This file may be used under the terms of the GNU General Public License version 2.0 as published by the Free Software Foundation and appearing in the file LICENSE included in the packaging of this file.  Please review the following information to ensure the GNU General Public License version 2.0 requirements will be met: http://www.gnu.org/copyleft/gpl.html.

If you are unsure which license is appropriate for your use, please contact the sales department at http://www.lanelife.org/contact.

*/
package net.lanelife.framework.os.components
{
	import flash.events.MouseEvent;
	
	import mx.core.FlexGlobals;
	
	import net.lanelife.framework.os.components.events.StartMenuEvent;
	import net.lanelife.framework.os.core.ScreenContext;
	
	import spark.components.ToggleButton;
	
	public class StartButton extends ToggleButton
	{
		
		public var screenContext:ScreenContext;
		
		public function StartButton()
		{
			super();
			this.addEventListener(MouseEvent.CLICK, function(event:MouseEvent):void{
				FlexGlobals.topLevelApplication.parent.addEventListener(MouseEvent.MOUSE_DOWN, parent_mouseDownHandler);
				screenContext.raiseEvent(StartMenuEvent.SHOW);
				screenContext.observer(StartMenuEvent.HIDE, hideStartMenu, true);
			});
			
		}
		
		
		private function hideStartMenu():void {
			this.selected = false;
		}
		
		
		public static var display:Boolean = false;
		
		private function parent_mouseDownHandler(event:MouseEvent):void
		{
			if (!display) {
				FlexGlobals.topLevelApplication.parent.removeEventListener(MouseEvent.MOUSE_DOWN, parent_mouseDownHandler);
				screenContext.raiseEvent(StartMenuEvent.HIDE);
			}
		}
	}
}