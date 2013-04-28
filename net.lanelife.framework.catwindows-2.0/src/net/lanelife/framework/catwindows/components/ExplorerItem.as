package net.lanelife.framework.catwindows.components
{
	import spark.components.Button;
	
	/**
	 * 资源管理器中的项，icon指定项图标，moduleUrl指定项模块地址，label指定项名称
	 * @author Lane
	 * 
	 */
	public class ExplorerItem extends Button
	{
		
		[Bindable]
		/**
		 * 图标 
		 * @return 
		 * 
		 */
		public var icon:Object;
		
		[Bindable]
		/**
		 * 模块地址 
		 * @return 
		 * 
		 */
		public var moduleUrl:String;
		
		public var winIcon:String;
		public var winTitle:String;
		public function ExplorerItem()
		{
			super();
		}
	}
}