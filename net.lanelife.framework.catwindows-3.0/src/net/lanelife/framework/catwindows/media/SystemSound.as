/*

This file is part of LANE WEBOS

Copyright (c) 2011 LANE WEBOS

Contact:  http://www.lanelife.org/contact

GNU General Public License Usage
This file may be used under the terms of the GNU General Public License version 2.0 as published by the Free Software Foundation and appearing in the file LICENSE included in the packaging of this file.  Please review the following information to ensure the GNU General Public License version 2.0 requirements will be met: http://www.gnu.org/copyleft/gpl.html.

If you are unsure which license is appropriate for your use, please contact the sales department at http://www.lanelife.org/contact.

*/
package net.lanelife.framework.catwindows.media
{
	import mx.core.SoundAsset;

	public class SystemSound
	{
		[Embed('assets/sounds/ding.mp3')] 
		private static var dingSound:Class; 
		
		public static const DING:SoundAsset = new dingSound() as SoundAsset;
		
		public function SystemSound()
		{
		}
		
		public static function play(asset:SoundAsset):void
		{
			asset.play();
		}
	}
}