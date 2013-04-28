package net.lanelife.webos.utils
{
	import spark.modules.ModuleLoader;
	import flash.events.Event;
	import flash.utils.ByteArray;
	[Event(name="preUnload", type="flash.events.Event")]
	public class WtModuleLoader extends ModuleLoader
	{
		public function WtModuleLoader()
		{
			super();
		}
		override public function unloadModule():void{
			dispatchEvent(new Event("preUnload"));
			super.unloadModule();
		}
		
	}
}