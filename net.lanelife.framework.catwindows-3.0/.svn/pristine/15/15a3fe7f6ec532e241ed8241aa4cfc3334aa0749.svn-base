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
	import mx.collections.ArrayCollection;
	
	import net.lanelife.framework.catwindows.components.TrayIcon;
	

	public class TrayIconManager
	{
		
		private static var instance:TrayIconManager;
		
		/**
		 * 托盘图标管理器集合 
		 */		
		public static var trayIconManagers:ArrayCollection = new ArrayCollection();
		
		/**
		 * 托盘图标管理器ID 
		 */		
		public var id:Number;
		
		
		public var list:ArrayCollection = new ArrayCollection();
		
		
		public function TrayIconManager(id:Number)
		{
			this.id = id;
			
			TrayIconManager.trayIconManagers.addItem(this);
		}
		
		public static function getInstance():TrayIconManager
		{
			if (instance==null)
				instance = new TrayIconManager(0);
			return instance;
		}
		
		/**
		 * 通过id获得托盘图标管理器 
		 * @param id
		 * @return 
		 * 
		 */
		public static function getTrayIconManager(id:Number=0):TrayIconManager
		{
			for (var i:Number=0; i<TrayIconManager.trayIconManagers.length; i++)
			{
				if (TrayIconManager.trayIconManagers[i].id == id)
				{
					return TrayIconManager.trayIconManagers[i];
				}
			}
			return null;
		}
		
		public function register(trayIcon:TrayIcon):void
		{ 
			if (trayIcon.manager)
			{
				trayIcon.manager.unregister(trayIcon);
			}
			trayIcon.manager = this;
			list.addItem(trayIcon);
		}
		
		public function unregister(trayIcon:TrayIcon):void
		{
			trayIcon.manager = null;
			if (list.getItemIndex(trayIcon)>-1)
				list.removeItemAt(list.getItemIndex(trayIcon));
		}
		
		/**
		 * 通过id查找托盘图标 
		 * @param id
		 * @return TrayIcon实例
		 * 
		 */
		public function get(id:String):TrayIcon
		{
			for (var i:Number=0; i<list.length; i++)
			{
				if (list[i].id == id)
				{
					return list[i];
				}
			}
			return null;
		}
		
	}
}