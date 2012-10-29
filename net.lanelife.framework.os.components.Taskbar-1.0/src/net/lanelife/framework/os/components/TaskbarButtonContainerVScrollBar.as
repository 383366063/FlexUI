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
	
	import mx.core.mx_internal;
	
	import spark.components.VScrollBar;
	import spark.core.IViewport;
	
	use namespace mx_internal;
	
	public class TaskbarButtonContainerVScrollBar extends VScrollBar
	{
		override mx_internal function mouseWheelHandler(event:MouseEvent):void
		{
			const vp:IViewport = viewport;
			if (event.isDefaultPrevented() || !vp || !vp.visible)
				return;
			var delta:Number = event.delta;
			var direction:Number = 0;
			var distance:Number = 40;
			if (delta < 0){
				direction = 1;
			} else if (delta == 0){
				direction = 0;
			} else {
				direction = -1;
			}
			vp.verticalScrollPosition += distance * direction;
			event.preventDefault();
		}
	}
}