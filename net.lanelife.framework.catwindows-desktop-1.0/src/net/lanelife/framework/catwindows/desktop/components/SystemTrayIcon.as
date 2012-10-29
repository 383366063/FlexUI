/*

This file is part of LANE WEBOS

Copyright (c) 2011 LANE WEBOS

Contact:  http://www.lanelife.org/contact

GNU General Public License Usage
This file may be used under the terms of the GNU General Public License version 2.0 as published by the Free Software Foundation and appearing in the file LICENSE included in the packaging of this file.  Please review the following information to ensure the GNU General Public License version 2.0 requirements will be met: http://www.gnu.org/copyleft/gpl.html.

If you are unsure which license is appropriate for your use, please contact the sales department at http://www.lanelife.org/contact.

*/
package net.lanelife.framework.catwindows.desktop.components
{
	import net.lanelife.framework.catwindows.components.TrayIcon;
	import net.lanelife.framework.catwindows.events.TrayIconEvent;
	import net.lanelife.framework.catwindows.managers.TrayIconManager;
	import net.lanelife.framework.os.core.ScreenContext;
	import net.lanelife.framework.os.core.SystemContext;
	
	public class SystemTrayIcon extends TrayIcon
	{
		public var screenContext:ScreenContext;
		
		public function SystemTrayIcon(display:Boolean=true, screenContext:ScreenContext=null)
		{
			super(display);
			
			if (screenContext==null)
				screenContext = SystemContext.instance.currentScreenContext;
			this.screenContext = screenContext;
			
			
			this.manager = TrayIconManager.getTrayIconManager(this.screenContext.trayIconManagerId);
			this.manager.register(this);
			
			this.screenContext.raiseEvent(TrayIconEvent.TRAY_ICON_CREATE, this);
			
		}
		
		
		override public function destroy():void
		{
			super.destroy();
			this.screenContext.raiseEvent(TrayIconEvent.TRAY_ICON_DESTROY, this);
		}
	}
}