/*

This file is part of LANE WEBOS

Copyright (c) 2011 LANE WEBOS

Contact:  http://www.lanelife.org/contact

GNU General Public License Usage
This file may be used under the terms of the GNU General Public License version 2.0 as published by the Free Software Foundation and appearing in the file LICENSE included in the packaging of this file.  Please review the following information to ensure the GNU General Public License version 2.0 requirements will be met: http://www.gnu.org/copyleft/gpl.html.

If you are unsure which license is appropriate for your use, please contact the sales department at http://www.lanelife.org/contact.

*/
package net.lanelife.framework.catwindows.events
{
	import flash.events.Event;
	
	import net.lanelife.framework.catwindows.components.Window;
	
	public class WindowEvent extends Event
	{
		
		/**
		 * 窗口创建事件，在首次调用 show 方法传递此事件。 
		 */
		public static const WINDOW_CREATE:String = "windowCreate";
		
		/**
		 * 窗口打开事件，在每次调用 show 方法传递此事件。  
		 */
		public static const WINDOW_OPENED:String = "windowOpened";
		
		/**
		 * 窗口获得焦点事件。 
		 */
		public static const WINDOW_FOCUS_IN:String = "windowFocusIn";
		
		/**
		 * 窗口隐藏事件， 调用 hide、close 方法传递此事件。  
		 */
		public static const WINDOW_HIDDENED:String = "windowHiddened";
		
		/**
		 * 窗口最大化事件，调用 maximize 方法传递此事件。  
		 */
		public static const WINDOW_MAXIMIZE:String = "windowMaximize";
		
		/**
		 * 窗口还原事件，调用 restore 方法传递此事件。  
		 */
		public static const WINDOW_RESTORE:String = "windowRestore";
		
		/**
		 * 窗口关闭事件， 调用 close 方法传递此事件。  
		 */
		public static const WINDOW_CLOSED:String = "windowClosed";
		
		/**
		 * 窗口销毁事件，在调用 destroy 方法时分发。
		 */
		public static const WINDOW_DESTROY:String = "windowDestroy";
		
		
		/**
		 * 窗口激活事件类型。Window 成为活动 Window 时传递此事件。  
		 */
		public static const WINDOW_ACTIVATED:String = "windowActivated";
		
		/**
		 * 窗口停用事件类型。Window 不再是活动 Window 时传递此事件。
		 */
		public static const WINDOW_DEACTIVATED:String = "windowDeactivated";
		
		
		public var window:Window;
		
		public function WindowEvent(type:String, window:Window)
		{
			super(type);
			this.window = window;
		}
	}
}