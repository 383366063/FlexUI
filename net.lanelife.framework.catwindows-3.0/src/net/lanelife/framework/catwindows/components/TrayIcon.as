/*

This file is part of LANE WEBOS

Copyright (c) 2011 LANE WEBOS

Contact:  http://www.lanelife.org/contact

GNU General Public License Usage
This file may be used under the terms of the GNU General Public License version 2.0 as published by the Free Software Foundation and appearing in the file LICENSE included in the packaging of this file.  Please review the following information to ensure the GNU General Public License version 2.0 requirements will be met: http://www.gnu.org/copyleft/gpl.html.

If you are unsure which license is appropriate for your use, please contact the sales department at http://www.lanelife.org/contact.

*/
package net.lanelife.framework.catwindows.components
{
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import net.lanelife.framework.catwindows.managers.TrayIconManager;
	
	import spark.components.Button;
	import spark.components.Image;
	
	/**
	 * 托盘图标 
	 * @author Lane
	 * 
	 */
	public class TrayIcon extends Button
	{
		
		public var manager:TrayIconManager;
		
		public var display:Boolean;
		
		
		
		[Bindable]
		public var trayIconSource:Object;
		[Bindable]
		public var trayIconVisible:Boolean = true;
		
		
		public function TrayIcon(display:Boolean=true)
		{
			super();
			this.display = display;
			
			this.manager = this.manager || TrayIconManager.getInstance();
			
			this.manager.register(this);
			
		}
		
		
		/**
		 * 设置此 TrayIcon 的图像，建议使用16x16像素的图片。
		 * @param source
		 * 
		 */
		public function setImage(source:Object):void
		{
			trayIconSource = source;
		}
		
		private var timer:Timer;
		
		/**
		 * 开始闪烁 此 TrayIcon 的图像。 
		 * @param delay 间隔时间，默认为1000毫秒。
		 * 
		 */
		public function startFlashImage(delay:Number=1000):void
		{
			if (timer) {
				stopFlashImage();
				timer = null;
			}
			timer = new Timer(delay);
			timer.addEventListener(TimerEvent.TIMER, timer_timerHandler);
			timer.start();
		}
		
		/**
		 * 停止闪烁 此 TrayIcon 的图像。
		 * 
		 */
		public function stopFlashImage():void
		{
			if (timer) {
				timer.stop();
				timer.removeEventListener(TimerEvent.TIMER, timer_timerHandler);
				trayIconVisible = true;
			}
		}
		
		protected function timer_timerHandler(event:TimerEvent):void
		{
			trayIconVisible = !trayIconVisible;
		}
		
		public function destroy():void
		{
			if (this.manager)
			{
				this.manager.unregister(this);
			}
		}
	}
}