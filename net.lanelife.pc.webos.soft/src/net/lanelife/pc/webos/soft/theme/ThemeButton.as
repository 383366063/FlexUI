/*

This file is part of LANE WEBOS

Copyright (c) 2011 LANE WEBOS

Contact:  http://www.lanelife.org/contact

GNU General Public License Usage
This file may be used under the terms of the GNU General Public License version 2.0 as published by the Free Software Foundation and appearing in the file LICENSE included in the packaging of this file.  Please review the following information to ensure the GNU General Public License version 2.0 requirements will be met: http://www.gnu.org/copyleft/gpl.html.

If you are unsure which license is appropriate for your use, please contact the sales department at http://www.lanelife.org/contact.

*/
package net.lanelife.pc.webos.soft.theme
{
	import spark.components.Button;
	
	public class ThemeButton extends Button
	{
		
		[Bindable]
		public var themename:String;
		
		[Bindable]
		public var pic:Object;
		
		[Bindable]
		public var swf:String;
		
		[Bindable]
		public var background:String;
		
		[Bindable]
		public var chromeColor:String;
		
		
		public function ThemeButton()
		{
			super();
		}
	}
}