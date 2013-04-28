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
	
	import flash.events.Event;
	
	import spark.modules.ModuleLoader;
	
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