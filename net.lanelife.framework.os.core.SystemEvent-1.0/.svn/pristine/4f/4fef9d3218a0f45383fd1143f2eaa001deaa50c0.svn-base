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
	
	public class SystemEvent extends Event
	{
		public static const SYSTEM_EVENT:String = "systemEvent";
		
		
		public var params:Array;
		public var eventObj:*;
		
		public function SystemEvent(type:String,eventObj:*,params:Array, bubbles:Boolean=false, cancelable:Boolean=false, kind:String=null, property:Object=null, oldValue:Object=null, newValue:Object=null, source:Object=null)
		{
			super(type, true, false);
			this.params = params;
			this.eventObj = eventObj;
		}
		 
	}
}