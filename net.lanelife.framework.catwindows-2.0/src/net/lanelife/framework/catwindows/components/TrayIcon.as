package net.lanelife.framework.catwindows.components
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import net.lanelife.framework.catwindows.events.TrayIconEvent;
	import net.lanelife.framework.catwindows.events.WindowEventDispatcher;
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
		
		//[SkinPart(required="true")]
		//public var trayIconDisplay:Image;
		
		
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
			
			WindowEventDispatcher.getInstance().dispatchEvent(
				new TrayIconEvent(TrayIconEvent.TRAY_ICON_CREATE, this)
			);
			
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
		
		/**
		 * 销毁托盘图标 
		 * 
		 */
		public function destroy():void
		{
			if (this.manager)
			{
				WindowEventDispatcher.getInstance().dispatchEvent(
					new TrayIconEvent(TrayIconEvent.TRAY_ICON_DESTROY, this)
				);
				this.manager.unregister(this);
			}
		}
	}
}