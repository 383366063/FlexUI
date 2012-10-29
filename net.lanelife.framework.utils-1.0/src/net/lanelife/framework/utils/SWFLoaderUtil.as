/*

This file is part of LANE WEBOS

Copyright (c) 2011 LANE WEBOS

Contact:  http://www.lanelife.org/contact

GNU General Public License Usage
This file may be used under the terms of the GNU General Public License version 2.0 as published by the Free Software Foundation and appearing in the file LICENSE included in the packaging of this file.  Please review the following information to ensure the GNU General Public License version 2.0 requirements will be met: http://www.gnu.org/copyleft/gpl.html.

If you are unsure which license is appropriate for your use, please contact the sales department at http://www.lanelife.org/contact.

*/
package net.lanelife.framework.utils
{
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	
	import mx.controls.SWFLoader;
	import mx.core.ISWFLoader;
	import mx.core.IVisualElementContainer;
	import mx.events.ModuleEvent;
	import mx.modules.IModuleInfo;
	import mx.modules.ModuleManager;
	
	import net.lanelife.framework.os.core.ScreenContext;
	import net.lanelife.framework.os.core.SystemContext;
	
	import spark.modules.ModuleLoader;
	
	public class SWFLoaderUtil
	{
		public static function load(url:String, progressBar:ProgressBar=null, loadingMessage:String=null, okEvent:String='', domain:ApplicationDomain=null, fun:Function=null):void
		{
			
			if (progressBar==null)
				progressBar = new ProgressBar();
			
			if (loadingMessage==null)
				loadingMessage = "正在加载模块，请稍候...";
			
			var swfload:SWFLoader = new SWFLoader();
			var context:LoaderContext = new LoaderContext();
			context.applicationDomain = domain;
			swfload.loaderContext=context;
			var isLoaded:Boolean = false;
			swfload.load(url);
			swfload.addEventListener(ProgressEvent.PROGRESS, function(e:ProgressEvent):void{
				progressBar.progress(e as ProgressEvent, loadingMessage);
			});
			if('' != okEvent)
				SystemContext.instance.raiseEventAndRun(okEvent,swfload);
			if(fun!=null)
				fun.apply(null,[swfload]);
		}
		
		
		public static function loadApplication(screenContext:ScreenContext, url:String, progressBar:ProgressBar=null, loadingMessage:String=null, okEvent:String='', domain:ApplicationDomain=null, fun:Function=null):void
		{
			
			if (progressBar==null)
				progressBar = new ProgressBar();
			
			if (loadingMessage==null)
				loadingMessage = "正在加载模块，请稍候...";
			
			var module:ModuleLoader;
			
			module = new WtModuleLoader();
			module.applicationDomain=domain;
			
			var loadingFun:Function=function(e:ModuleEvent):void{
				if (e.bytesLoaded < e.bytesTotal)//{
					progressBar.progress(e as ProgressEvent, loadingMessage);
			};
			
			var errorFun:Function=function(event:ModuleEvent):void{
				progressBar.showError("加载失败："+event.errorText);
				event.currentTarget.removeEventListener(event.type,arguments.callee);
				event.currentTarget.removeEventListener(ModuleEvent.PROGRESS, loadingFun);
				event.currentTarget.removeEventListener("preUnload", preloadFun);
				event.currentTarget.removeEventListener(ModuleEvent.READY,readyFun);
			};
			
			var readyFun:Function=function(event:ModuleEvent):void{
				var loadedModule:Object=event.currentTarget.child;
				if(loadedModule)
				{
					if(loadedModule.hasOwnProperty("start"))
						loadedModule.start(screenContext, domain);
				}
				progressBar.close();
			};
			
			var preloadFun:Function=function(event:Event):void{
				var loadedModule:Object=event.currentTarget.child;
				if(loadedModule)
				{
					if(loadedModule.hasOwnProperty("stop"))
						loadedModule.stop(screenContext);	
				}
				event.currentTarget.removeEventListener(event.type,arguments.callee);
				event.currentTarget.removeEventListener(ModuleEvent.PROGRESS, loadingFun);
				//event.currentTarget.removeEventListener(ModuleEvent.ERROR, errorFun); //加上这句会造成失败事件侦听不到
				event.currentTarget.removeEventListener(ModuleEvent.READY,readyFun);
			}
				
			module.addEventListener(ModuleEvent.PROGRESS, loadingFun);
			module.addEventListener(ModuleEvent.ERROR, errorFun);
			module.addEventListener(ModuleEvent.READY,readyFun);
			module.addEventListener("preUnload",preloadFun);
			module.url=url;
			
			//AppContext.instance.addMoudule(url,module);
			if('' != okEvent)
				SystemContext.instance.raiseEvent(okEvent,module);
			if(fun!=null)
				fun.apply(null,[module]);
		}
	}
}