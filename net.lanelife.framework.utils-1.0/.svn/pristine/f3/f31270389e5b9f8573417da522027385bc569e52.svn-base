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
	public class X
	{
		/**
		 * 空函数
		 */
		public static var emptyFn:Function = function(...args):void { };
		
		/**
		 * 属性覆盖
		 * @param	des		目标对象
		 * @param	src		源对象
		 * @return
		 */
		public static function apply(des:*=null,src:*=null):*{
			if(!des){
				des={};
			}
			if(!src){
				return des;
			}
			for(var p:* in src){
				des[p]=src[p]
			}
			return des;
		}
	}
}