package net.lanelife.framework.catwindows.components
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.events.FlexEvent;
	
	import net.lanelife.framework.catwindows.containers.TaskbarButtonContainer;
	//import net.lanelife.framework.catwindows.containers.WindowsContainer;
	import net.lanelife.framework.catwindows.core.SystemContext;
	import net.lanelife.framework.catwindows.core.SystemVariables;
	
	import spark.components.HGroup;
	import spark.components.SkinnableContainer;
	
	
	public class DesktopNavigator extends SkinnableContainer
	{
		
		public var quantity:Number = 1;
		
		public static var list:ArrayCollection = new ArrayCollection();
		
		public var selectedIndex:Number = 0;
		
		[Bindable]
		public var desktopNavigatorButtons:ArrayCollection = new ArrayCollection();

		
		private function changeIndex(index:Number):void
		{
			list.getItemAt(selectedIndex).selected=false;
			list.getItemAt(index).selected=true;
			selectedIndex = index;
			
			SystemVariables.currentDesktopScreenIndex = index;
		}
		
		
		public function DesktopNavigator()
		{
			super();
			
			this.addEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler)
			
		}
		
		
		private function creationCompleteHandler(event:FlexEvent):void
		{
			for (var i:Number=1; i<=quantity; i++)
			{
				var button:DesktopNavigatorButton = new DesktopNavigatorButton();
				button.label = String(i);
				button.useHandCursor = true;
				button.addEventListener(MouseEvent.CLICK, button_clickHandler);
				
				list.addItem(button);
				
				desktopNavigatorButtons.addItem(button);
				
				var o:Object = new Object();
				SystemVariables.taskbarButtonContainers.addItem(o);
				SystemVariables.windowsContainers.addItem(o);
				
			}
			changeIndex(selectedIndex);
		}
		
		private function button_clickHandler(event:MouseEvent):void
		{
			changeIndex(parseInt((event.target as DesktopNavigatorButton).label)-1);
		}
		
	}
}