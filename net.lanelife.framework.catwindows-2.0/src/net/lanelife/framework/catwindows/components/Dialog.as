package net.lanelife.framework.catwindows.components
{
	public class Dialog extends Window
	{
		public function Dialog(title:String=null, owner:Window=null, modal:Boolean=true)
		{
			super(title, owner);
			this.modal = modal;
			this.maximizable = false;
			this.resizable = false;
		}
	}
}