package net.lanelife.webos.utils
{
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.Timer;
	import flash.utils.setTimeout;
	
	import mx.controls.SWFLoader;
	import mx.core.ISWFLoader;
	import mx.core.IVisualElementContainer;
	import mx.events.ModuleEvent;
	import mx.modules.IModuleInfo;
	import mx.modules.ModuleManager;
	
	import net.lanelife.framework.catwindows.core.SystemContext;
	import net.lanelife.framework.catwindows.utils.ProgressBar;
	
	import spark.modules.ModuleLoader;
	
	public class SWFLoadUtil
	{
		public function ct_load(url:String, progressBar:ProgressBar, okEvent:String='',domain:ApplicationDomain=null,fun:Function=null):void{
			var swfload:SWFLoader = new SWFLoader();
			var context:LoaderContext = new LoaderContext();
			context.applicationDomain = domain;
			swfload.loaderContext=context;
			var isLoaded:Boolean = false;
			swfload.load(url);
			swfload.addEventListener(ProgressEvent.PROGRESS, function(e:ProgressEvent):void{
				progressBar.progress(e as ProgressEvent, "正在加载模块，请稍候...");
			});
			if('' != okEvent)
				SystemContext.instance.raiseEventAndRun(okEvent,swfload);
			if(fun!=null)
				fun.apply(null,[swfload]);
		}
		public function ct_AutoModuleLoad(url:String, progressBar:ProgressBar,okEvent:String='',domain:ApplicationDomain=null,fun:Function=null):void{
			
			var module:ModuleLoader;
			var eventStr:String = "mouleLoaded-"+Math.random();
			module = new WtModuleLoader();
			var moduleinfo:IModuleInfo=ModuleManager.getModule(url);
			if(moduleinfo.loaded)
			{
				module.url=url;
				if('' != okEvent)
					SystemContext.instance.raiseEvent(okEvent,module);
				if(fun!=null)
					fun.apply(null,[module,eventStr]);
				SystemContext.instance.raiseEventAndRun(eventStr);
				SystemContext.instance.deleteEvent(eventStr);
				return;
			}
			var loadingFun:Function=function(e:ModuleEvent):void{
				if (e.bytesLoaded < e.bytesTotal)//{
					progressBar.progress(e as ProgressEvent, "正在加载模块，请稍候...");
			};
			var errorFun:Function=function(event:ModuleEvent):void{
				trace(event.errorText);
				event.currentTarget.removeEventListener(event.type,arguments.callee);
				event.currentTarget.removeEventListener(ModuleEvent.PROGRESS, loadingFun);
				event.currentTarget.removeEventListener("preUnload", preUnloadFun);
				event.currentTarget.removeEventListener(ModuleEvent.READY,readyFun);
				progressBar.close();
			};
			var readyFun:Function=function(event:ModuleEvent):void{
				var loadedModule:Object=event.currentTarget.child;
				if(loadedModule)
				{
					if(loadedModule.hasOwnProperty("startModule"))
						loadedModule.startModule(domain);
				}
				SystemContext.instance.raiseEventAndRun(eventStr);
				SystemContext.instance.deleteEvent(eventStr);
			};
			var preUnloadFun:Function=function(event:Event):void{
				var loadedModule:Object=event.currentTarget.child;
				if(loadedModule)
				{
					if(loadedModule.hasOwnProperty("stopModule"))
						loadedModule.stopModule();	
				}
				event.currentTarget.removeEventListener(event.type,arguments.callee);
				event.currentTarget.removeEventListener(ModuleEvent.PROGRESS, loadingFun);
				event.currentTarget.removeEventListener(ModuleEvent.ERROR, errorFun);
				event.currentTarget.removeEventListener(ModuleEvent.READY,readyFun);
			}
			module.addEventListener(ModuleEvent.PROGRESS, loadingFun);
			module.addEventListener(ModuleEvent.ERROR, errorFun);
			module.addEventListener(ModuleEvent.READY,readyFun);
			module.addEventListener("preUnload",preUnloadFun);
			
			module.applicationDomain=domain;
			module.url=url;
			if('' != okEvent)
				SystemContext.instance.raiseEvent(okEvent,module);
			if(fun!=null)
				fun.apply(null,[module,eventStr]);
		}
	}
}