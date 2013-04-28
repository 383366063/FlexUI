/*

This file is part of LANE WEBOS

Copyright (c) 2011 LANE WEBOS

Contact:  http://www.lanelife.org/contact

GNU General Public License Usage
This file may be used under the terms of the GNU General Public License version 2.0 as published by the Free Software Foundation and appearing in the file LICENSE included in the packaging of this file.  Please review the following information to ensure the GNU General Public License version 2.0 requirements will be met: http://www.gnu.org/copyleft/gpl.html.

If you are unsure which license is appropriate for your use, please contact the sales department at http://www.lanelife.org/contact.

*/
package net.lanelife.framework.os.components
{
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.events.FlexEvent;
	
	import net.lanelife.framework.os.core.SystemContext;
	
	import spark.components.SkinnableContainer;
	import spark.effects.Rotate3D;
	
	public class ScreenNavigator extends SkinnableContainer
	{
		
		[Bindable]
		public var navigatorButtons:ArrayCollection = new ArrayCollection();
		
		
		public function ScreenNavigator()
		{
			super();
			
			this.addEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler)
		}
		
		private function creationCompleteHandler(event:FlexEvent):void
		{
			for (var i:Number=1; i<=SystemContext.instance.systemVariables.screenNumber; i++)
			{
				var button:ScreenNavigatorButton = new ScreenNavigatorButton();
				button.label = String(i);
				button.useHandCursor = true;
				button.addEventListener(MouseEvent.CLICK, button_clickHandler);
				navigatorButtons.addItem(button);
			}
			changeIndex(SystemContext.instance.systemVariables.screenIndex);
		}
		
		private function button_clickHandler(event:MouseEvent):void
		{
			changeIndex(parseInt((event.target as ScreenNavigatorButton).label)-1);
		}
		
		private function changeIndex(index:Number):void
		{
			navigatorButtons.getItemAt(SystemContext.instance.systemVariables.screenIndex).selected=false;
			navigatorButtons.getItemAt(index).selected=true;
			
			SystemContext.instance.systemVariables.screenIndex = index;
			
			//SystemContext.instance.currentScreenContext.screenContainer.left=null;
			//SystemContext.instance.currentScreenContext.screenContainer.right=null;
			
			var showEffect:Rotate3D = new Rotate3D();
			showEffect.angleYFrom = 180;
			showEffect.angleYTo = 0;
			showEffect.autoCenterTransform = true;
			
			//SystemContext.instance.desktopExplorers.getItemAt(SystemContext.instance.systemVariables.screenIndex).visible = false;
			//SystemContext.instance.desktopExplorers.getItemAt(index).visible = true;
			
			//SystemContext.instance.currentScreenContext.screenContainer.setStyle("hideEffect", hideEffect);
			SystemContext.instance.currentScreenContext.screenContainer.visible = false;
			
			SystemContext.instance.currentScreenContext = SystemContext.instance.screenContexts[SystemContext.instance.systemVariables.screenIndex];
			
			SystemContext.instance.currentScreenContext.screenContainer.setStyle("showEffect", showEffect);
			SystemContext.instance.currentScreenContext.screenContainer.visible = true;

			
		}
	}
}