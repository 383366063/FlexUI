/*

This file is part of LANE WEBOS

Copyright (c) 2011 LANE WEBOS

Contact:  http://www.lanelife.org/contact

GNU General Public License Usage
This file may be used under the terms of the GNU General Public License version 2.0 as published by the Free Software Foundation and appearing in the file LICENSE included in the packaging of this file.  Please review the following information to ensure the GNU General Public License version 2.0 requirements will be met: http://www.gnu.org/copyleft/gpl.html.

If you are unsure which license is appropriate for your use, please contact the sales department at http://www.lanelife.org/contact.

*/
package net.lanelife.framework.catwindows.managers
{
	import mx.managers.CursorManager;
	import mx.managers.CursorManagerPriority;

	public class CursorMgr
	{
		
		[Embed(source="assets/cursors/ns.png")]
		public static const NS:Class;
		
		[Embed(source="assets/cursors/ew.png")]
		public static const EW:Class;
		
		[Embed(source="assets/cursors/nesw.png")]
		public static const NESW:Class;
		
		[Embed(source="assets/cursors/nwse.png")]
		public static const NWSE:Class;
		
		public static const SIDE_OTHER:Number = 0;
		public static const SIDE_TOP:Number = 1;
		public static const SIDE_BOTTOM:Number = 2;
		public static const SIDE_LEFT:Number = 4;
		public static const SIDE_RIGHT:Number = 8;
		
		private static var currentType:Class = null;
		
		public static function setCursor(type:Class, xOffset:Number = 0, yOffset:Number = 0):void
		{
			if(currentType != type){
				currentType = type;
				CursorManager.removeCursor(CursorManager.currentCursorID);
				if(type != null){
					CursorManager.setCursor(type, CursorManagerPriority.MEDIUM, xOffset, yOffset);
				}
			}
		}
		
	}
}