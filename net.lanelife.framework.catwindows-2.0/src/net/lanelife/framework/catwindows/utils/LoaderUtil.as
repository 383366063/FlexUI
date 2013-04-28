package net.lanelife.framework.catwindows.utils
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	
	import mx.controls.Alert;
	
	import net.lanelife.framework.catwindows.core.SystemContext;

	public class LoaderUtil
	{
		public static function ct_setBySource(_imgUrl:String, obj:Object=null,loadingText:String='', preload:ProgressBar=null, style:String='', okFunc:Function=null):void{
			if (null == _imgUrl || '' == _imgUrl){
				if (null != okFunc){
					okFunc.call(null);
				}
			}
			var loader:Loader = new Loader();
			loader.load(new URLRequest(_imgUrl as String));
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, function():void{
				Alert.show('资源加载失败！' + _imgUrl);
				if (null != okFunc){
					okFunc.call(null);
				}
			});
			
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(e:Event):void{
				if (null != obj){
					if ('class' != style && 'icon' == style){
						obj.setStyle(style, e.target.content);
					}else{
						obj.source = e.target.content;
					}
				}
				if (null != okFunc){
					okFunc.call(null);
				}
			});
			
			if (null != preload){
				loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, function(e:ProgressEvent):void{
					preload.progress(e,"正在加载"+loadingText+"，请稍候...");
				});
			}
		}

		public static function load(objs:Array, progressBar:ProgressBar, resultFuntion:Function, okFunc:Function=null):void
		{
			progressBar.total = objs.length;
			progressBar.current = 0;
			var eventStr:String = "loaderUtil_load"+Math.random();
			var loadCount:Number=0;
			SystemContext.instance.observer(eventStr, function():void {
				loadCount++;
				progressBar.current = loadCount;
				if(objs.length==loadCount)
				{
					if(okFunc!=null)
						okFunc.call(this);
					SystemContext.instance.deleteEvent(eventStr);
					progressBar.close();
				}
			});
			for each (var obj:Object in objs)
			{
				
				if(obj!="")
				{
					var loader:Loader = new Loader();
					
					var loadingFun:Function=function(e:ProgressEvent):void{
						progressBar.progress(e,"正在加载"+obj.text+"，请稍候...");
					};
					
					var errorFun:Function=function(ee:IOErrorEvent):void{
						ee.currentTarget.removeEventListener(Event.COMPLETE,completeFun);
						ee.currentTarget.removeEventListener(ProgressEvent.PROGRESS,loadingFun);
						ee.currentTarget.removeEventListener(IOErrorEvent.IO_ERROR,errorFun);
						progressBar.showError(obj.text+"加载失败");
					};
					
					var completeFun:Function=function(ce:Event):void{
						resultFuntion.call(null,loadCount,obj.url,ce.target.content);
						ce.currentTarget.removeEventListener(Event.COMPLETE,completeFun);
						ce.currentTarget.removeEventListener(ProgressEvent.PROGRESS,loadingFun);
						ce.currentTarget.removeEventListener(IOErrorEvent.IO_ERROR,errorFun);
						loader = null;
						SystemContext.instance.raiseEventAndRun(eventStr);
					};
					
					loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeFun);
					loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, loadingFun);
					loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, errorFun);
					
					loader.load(new URLRequest(obj.url));
					
				}
				else
					SystemContext.instance.raiseEventAndRun(eventStr);
				
				
			}
		}

		
	}
}