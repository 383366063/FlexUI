package net.lanelife.framework.catwindows.core
{
	import mx.collections.ArrayCollection;

	[Bindable]
	public class SystemVariables
	{
		/**
		 * 窗口容器集合 
		 */
		public static var windowsContainers:ArrayCollection = new ArrayCollection();
		/**
		 * 任务栏按钮容器集合 
		 */
		public static var taskbarButtonContainers:ArrayCollection = new ArrayCollection();
		/**
		 * 当前桌面屏幕索引 
		 */
		public static var currentDesktopScreenIndex:Number = 0;
		
		/**
		 * 系统用户
		 */
		public static var systemUser:SystemUser;
		
		public function SystemVariables()
		{
		}
	}
}