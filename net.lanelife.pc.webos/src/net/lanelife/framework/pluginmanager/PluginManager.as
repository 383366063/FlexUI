/*

This file is part of LANE WEBOS

Copyright (c) 2011 LANE WEBOS

Contact:  http://www.lanelife.org/contact

GNU General Public License Usage
This file may be used under the terms of the GNU General Public License version 2.0 as published by the Free Software Foundation and appearing in the file LICENSE included in the packaging of this file.  Please review the following information to ensure the GNU General Public License version 2.0 requirements will be met: http://www.gnu.org/copyleft/gpl.html.

If you are unsure which license is appropriate for your use, please contact the sales department at http://www.lanelife.org/contact.

*/
package net.lanelife.framework.pluginmanager
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.getDefinitionByName;
	
	import mx.core.FlexGlobals;
	import mx.core.IVisualElement;
	
	import net.lanelife.framework.events.PreloaderEvent;
	import net.lanelife.framework.os.core.SystemContext;
	
	/**
	 * 插件管理器
	 */
	public class PluginManager extends EventDispatcher
	{
		public function PluginManager()
		{
		}
		
		/**
		 * 加载插件配置，安装插件
		 */
		public function install(xmlUrl:String):void
		{
			var xmlLoader:URLLoader = new URLLoader();
			
			xmlLoader.addEventListener(Event.COMPLETE,function(event:Event):void {
				
				var xml:XML = XML(event.target.data);
				
				init(xml.plugin, FlexGlobals.topLevelApplication)
				
				dispatchEvent(new PreloaderEvent(PreloaderEvent.ALL_OK, "", "", "", 0));
				
			});
			
			xmlLoader.addEventListener(ProgressEvent.PROGRESS, function(event:ProgressEvent):void {
				dispatchEvent(
					new PreloaderEvent(
						PreloaderEvent.PROGRESS, 
						"正在加载插件配置...", 
						size2str(event.bytesLoaded)+" / "+size2str(event.bytesTotal), 
						"1/1", 
						Math.ceil(event.bytesLoaded/event.bytesTotal*100) 
					)
				);
			});
			
			xmlLoader.addEventListener(IOErrorEvent.IO_ERROR, function(event:IOErrorEvent):void {
				dispatchEvent(new PreloaderEvent(PreloaderEvent.PROGRESS,"插件配置加载失败", "", "", 0));
			});
			
			xmlLoader.load(new URLRequest(xmlUrl));
		}
		
		/**
		 * 初始化插件
		 */
		private function init(plugins:XMLList, parentObj:Object):void
		{
			for (var i:int=0; i<plugins.length(); i++){ //循环插件
				
				var _class:Class = Class(getDefinitionByName(plugins[i].classname)); //获得插件类
				var o:Object = new _class as Object; //实例化插件
				
				
				for (var j:Number=0; j<plugins[i].propertys.children().length(); j++) //循环插件属性
				{
					var property:Object = plugins[i].propertys.children()[j]; //取得插件属性
					setProperty(o, property); //设置插件属性
				}
				
				if (plugins[i].context.toString()!="") //设置屏幕控制器
				{
					//trace(plugins[i].name+"=="+plugins[i].context.toString())
					o.screenContext = SystemContext.instance.screenContexts[parseInt(plugins[i].context)];
				}
				
				for (var bci:Number=0; bci<plugins[i].beforeCalls.call.length(); bci++) //循环插件实例化后调用的方法
				{
					var parameters:XMLList = plugins[i].beforeCalls.call[bci].parameters.parameter;
					for (var bcpi:Number=0; bcpi<parameters.length(); bcpi++)
					{
					}
					
					o[plugins[i].beforeCalls.call[bci].method](); //参数怎么传呢???
				}
				
				parentObj.addElement(o as IVisualElement); //添加显示
				
				if ( plugins[i].plugins.plugin.length()>0 )
				{
					init(plugins[i].plugins.plugin, o); //初始化子级插件
				}
				
			}
		}
		
		/**
		 * 设置插件属性
		 */
		private function setProperty(target:Object, property:Object):void
		{
			var propertyName:String = property.name();
			var propertyValue:String = property.text();
			
			if (propertyName=="left")
				target.left = parseFloat(propertyValue);
			else if (propertyName=="top")
				target.top = parseFloat(propertyValue);
			else if (propertyName=="right")
				target.right = parseFloat(propertyValue);
			else if (propertyName=="bottom")
				target.bottom = parseFloat(propertyValue);
			else if (propertyValue=="true")
				target[propertyName] = true;
			else if (propertyValue=="false")
				target[propertyName] = false;
			else
				target[propertyName] = propertyValue; //设置插件属性
			
		}
		
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