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
	import flash.display.StageDisplayState;
	import flash.events.MouseEvent;
	
	import mx.core.FlexGlobals;
	
	import spark.components.Button;
	
	public class FullScreenButton extends Button
	{
		public function FullScreenButton()
		{
			super();
			this.addEventListener(MouseEvent.CLICK, function(event:MouseEvent):void{
				if (FlexGlobals.topLevelApplication.stage.displayState==StageDisplayState.NORMAL)
					FlexGlobals.topLevelApplication.stage.displayState = StageDisplayState.FULL_SCREEN;
				else
					FlexGlobals.topLevelApplication.stage.displayState = StageDisplayState.NORMAL;
			});
		}
	}
}