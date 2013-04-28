/*

This file is part of LANE WEBOS

Copyright (c) 2011 LANE WEBOS

Contact:  http://www.lanelife.org/contact

GNU General Public License Usage
This file may be used under the terms of the GNU General Public License version 2.0 as published by the Free Software Foundation and appearing in the file LICENSE included in the packaging of this file.  Please review the following information to ensure the GNU General Public License version 2.0 requirements will be met: http://www.gnu.org/copyleft/gpl.html.

If you are unsure which license is appropriate for your use, please contact the sales department at http://www.lanelife.org/contact.

*/
package net.lanelife.framework.os.core
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	
	import mx.core.FlexGlobals;
	
	import net.lanelife.framework.catwindows.desktop.components.DesktopWindow;
	import net.lanelife.framework.utils.ProgressBar;
	import net.lanelife.framework.utils.SWFLoaderUtil;
	
	import spark.modules.ModuleLoader;

	public class ApplicationManager
	{
		public function ApplicationManager()
		{
		}
		
		
		public static function run(applicationXML:String, screenContext:ScreenContext):void
		{
			var progressBar:ProgressBar = new ProgressBar();
			
			var xmlLoader:URLLoader = new URLLoader();
			
			xmlLoader.addEventListener(ProgressEvent.PROGRESS, function(event:ProgressEvent):void {
				progressBar.progress(event, "正在读取应用配置...");
			});
			
			xmlLoader.addEventListener(IOErrorEvent.IO_ERROR, function(event:IOErrorEvent):void {
				progressBar.showError("应用配置读取失败");
			});
			
			xmlLoader.addEventListener(Event.COMPLETE,function(event:Event):void {
				
				var applicationConfig:XML = XML(event.target.data); //application.xml
				
				
				SWFLoaderUtil.loadApplication(screenContext, applicationConfig.module, progressBar, "正在加载"+applicationConfig.name+"，请稍候...", "", ApplicationDomain.currentDomain,
					function(moduleLoader:ModuleLoader):void{
						
						if (applicationConfig.runWith=="wrapper")
						{
							var desktopWindow:DesktopWindow = new DesktopWindow();
							
							if (applicationConfig.icon.toString()!="")
								desktopWindow.icon = applicationConfig.icon.toString();
							
							desktopWindow.title = applicationConfig.title.toString();
							desktopWindow.x = parseFloat(applicationConfig.x);
							desktopWindow.y = parseFloat(applicationConfig.y);
							desktopWindow.width = parseFloat(applicationConfig.width);
							desktopWindow.height = parseFloat(applicationConfig.height);
							if (applicationConfig.minimizable=="false")
								desktopWindow.minimizable = false;
							if (applicationConfig.maximizable=="false")
								desktopWindow.maximizable = false;
							if (applicationConfig.resizable=="false")
								desktopWindow.resizable = false;
							if (applicationConfig.draggable=="false")
								desktopWindow.draggable = false;
							if (applicationConfig.taskbarButtonVisible=="false")
								desktopWindow.taskbarButtonVisible = false;
							desktopWindow.addElement(moduleLoader);
							desktopWindow.show();
							if (applicationConfig.minimize=="true")
								desktopWindow.minimize();
							if (applicationConfig.maximize=="true")
								desktopWindow.maximize();
						}
						else
						{
							FlexGlobals.topLevelApplication.addElement(moduleLoader);
						}
						
						
					}
				);

				
			});
			xmlLoader.load(new URLRequest(applicationXML));
			
		}
	}
}