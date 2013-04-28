package net.lanelife.framework.catwindows.components
{
	import spark.components.Button;
	import spark.components.HGroup;
	import spark.components.Image;
	import spark.components.Label;

	/**
	 * 消息框类 
	 * @author Lane
	 * 
	 */
	public class MessageBox extends Window
	{
		
		public static const YES:uint = 0x0001;
		public static const NO:uint = 0x0002;
		public static const OK:uint = 0x0004;
		public static const CANCEL:uint= 0x0008;
		
		public static var yesLabel:String = "是";
		public static var noLabel:String = "否";
		public static var okLabel:String = "确定";
		public static var cancelLabel:String = "取消";
		
		public static var buttonHeight:Number = 22;
		public static var buttonWidth:Number = 65;
		public static var buttonAlign:String = "right";
		
		public var buttonFlags:uint = OK;
		public var defaultButtonFlag:uint = OK;
		[Bindable]
		public var iconObject:Object;
		public var text:String = "";
		
		public var defaultSelectedButton:Button;
		
		private var buttons:Array = [];
		private var defaultButtonChanged:Boolean = false;
		
		[SkinPart(required="false")]
		/**
		 * 位于  Prompt 控件中文本左侧的图标的外观组件。
		 */
		public var promptIconDisplay:Image;
		
		[SkinPart(required="false")]
		/**
		 * 在  Prompt 控件中显示的文本字符串的外观组件。
		 */
		public var textDisplay:Label;
		
		[SkinPart(required="false")]
		/**
		 * Prompt 控件中显示按钮的外观组件。
		 */
		public var buttonsGroup:HGroup;
		
		
		public function MessageBox(title:String=null, owner:Window=null)
		{
			super(title, owner);
		}
	}
}