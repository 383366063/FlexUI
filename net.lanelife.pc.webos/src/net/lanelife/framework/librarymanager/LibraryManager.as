/*

This file is part of LANE WEBOS

Copyright (c) 2011 LANE WEBOS

Contact:  http://www.lanelife.org/contact

GNU General Public License Usage
This file may be used under the terms of the GNU General Public License version 2.0 as published by the Free Software Foundation and appearing in the file LICENSE included in the packaging of this file.  Please review the following information to ensure the GNU General Public License version 2.0 requirements will be met: http://www.gnu.org/copyleft/gpl.html.

If you are unsure which license is appropriate for your use, please contact the sales department at http://www.lanelife.org/contact.

*/
package net.lanelife.framework.librarymanager
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	
	import net.lanelife.framework.events.PreloaderEvent;

	/**
	 * LIB管理类，加载配置文件中的所有lib并派发当前加载信息
	 */
	public class LibraryManager extends EventDispatcher
	{
		public function LibraryManager()
		{
		}
		
		// Lib 全部加载完，派发此名称的事件
		public static const LOADED:String = 'librarysLoaded';

		// lib配置文件
		private var xml:XML;
		
		// 当前加载索引
		private var currentLoadIndex:Number = 0;
		
		// 总 Lib 数
		private var totalLibrarys:Number = 0;
		
		/**
		 * 加载 Lib的xml配置文件，加载完配置文件后按照配置文件里面的配置依次加载所有的LIB
		 */
		public function install(xmlUrl:String):void
		{
			
			var xmlLoader:URLLoader = new URLLoader();
			
			xmlLoader.addEventListener(Event.COMPLETE,function(event:Event):void {
				
				xml = XML(event.target.data);
				
				totalLibrarys = xml.library.length();
				
				load(currentLoadIndex);
				
			});
			
			/**
			 * 将加载xml的信息往外派发
			 */
			xmlLoader.addEventListener(ProgressEvent.PROGRESS, function(event:ProgressEvent):void {
				dispatchEvent(
					new PreloaderEvent(
						PreloaderEvent.PROGRESS, 
						"正在读取类库配置文件...", 
						size2str(event.bytesLoaded)+" / "+size2str(event.bytesTotal), 
						"1/1", 
						Math.ceil(event.bytesLoaded/event.bytesTotal*100) 
					)
				);
			});
			
			xmlLoader.addEventListener(IOErrorEvent.IO_ERROR, function(event:IOErrorEvent):void {
				dispatchEvent(new PreloaderEvent(PreloaderEvent.PROGRESS,"类库配置文件加载失败", "", "", 0));
			});
			
			xmlLoader.load(new URLRequest(xmlUrl));
		}
		
		/**
		 * 按照索引加载 Lib，循环递归加载，直到全部加载完成，并派发当前加载信息，加载完毕后派发 LibraryManager.LOADED事件
		 */
		private function load(index:Number):void
		{
			if ( currentLoadIndex < totalLibrarys )
			{
				var loader:Loader = new Loader();
				var loaderContext:LoaderContext = new LoaderContext();
				loaderContext.applicationDomain = ApplicationDomain.currentDomain;
				
				/**
				 * 加载完成，继续加载下一个Lib
				 */
				loader.contentLoaderInfo.addEventListener(Event.INIT, function(ie:Event):void{
					load(currentLoadIndex++);
				});
				
				loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, function(pe:ProgressEvent):void{
					dispatchEvent(
						new PreloaderEvent(
							PreloaderEvent.PROGRESS, 
							"正在加载"+xml.library[currentLoadIndex].name+"...", 
							size2str(pe.bytesLoaded)+" / "+size2str(pe.bytesTotal), 
							(currentLoadIndex+1)+"/"+totalLibrarys, 
							Math.ceil(pe.bytesLoaded/pe.bytesTotal*100) 
						)
					);
				});
				
				loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, function(ee:IOErrorEvent):void{
					dispatchEvent(
						new PreloaderEvent(
							PreloaderEvent.PROGRESS, xml.library[currentLoadIndex].name+"加载失败", "", "", 0 
						)
					);
				});
				
				loader.load(new URLRequest(xml.library[currentLoadIndex].url), loaderContext);
			}
			else
			{
				//trace("全部加载完成")
				dispatchEvent(new Event(LibraryManager.LOADED));
			}
		}
		
		/**
		 * 将byte的数字转换成适当单位的字符
		 * 如：
		 * 	800 ==> 800 Bytes
		 * 	2048 ==> 2 KB
		 * 	2*1024*1024 ==> 2MB
		 */
		private function size2str(size:Number):String
		{
			var m:Array = [ " Bytes", " KB", " MB" ];
			for(var i:int=0,n:int=m.length; i<n && size>=1024; i++)
			{
				size /= 1024;
			}
			return (i>0 ? size.toFixed(i) : int(size) ) + m[i];
		}
		
	}
}