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