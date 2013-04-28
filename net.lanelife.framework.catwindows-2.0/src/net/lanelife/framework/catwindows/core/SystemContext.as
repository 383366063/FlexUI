package net.lanelife.framework.catwindows.core
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.system.ApplicationDomain;
	import flash.utils.Dictionary;
	import flash.utils.IExternalizable;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import mx.core.FlexGlobals;
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.logging.targets.TraceTarget;
	import mx.utils.ObjectProxy;
	import mx.utils.ObjectUtil;
	
	import net.lanelife.framework.catwindows.events.SystemEvent;
	
	import spark.modules.ModuleLoader;
	
	[Bindable]
	public dynamic class SystemContext extends ObjectProxy implements IEventDispatcher
	{
		
		private static var log:ILogger = Log.getLogger("SystemContext");
		private static var _instance:SystemContext;
		private var _newListeners:Dictionary = new Dictionary(true);
		private var _moudules:Dictionary=new Dictionary(true);
		private var _values:Object;
		
		public function SystemContext(item:Object = null)
		{
			if (!item)
				item = {};
			_values = item;
			addEventListener(SystemEvent.SYSTEM_EVENT, listenSystemEvent,false,0,true);
		}
		
		public static function get instance():SystemContext 
		{
			if (!_instance)
			{
				_instance = new SystemContext();
				var app:Object = _instance.currentApplication();
				_instance.application = app;
				_instance.currDomain = ApplicationDomain.currentDomain;
				_instance.appDomain = new ApplicationDomain(ApplicationDomain.currentDomain);
				var _target:TraceTarget = new TraceTarget();
				_target.filters = ["SystemContext"];
				//_target.includeDate = true; //显示日期
				//_target.includeTime = true; //显示trace的时间
				//_target.includeLevel = true; // 显示级别(error, debug, info .....)
				//_target.includeCategory = true; //显示种类
				//_target.level = LogEventLevel.ALL;
				Log.addTarget(_target);
			}
			return _instance;
		}
		
		public function addMoudule(url:String, moduleLoader:ModuleLoader):void
		{
			_moudules[url] = moduleLoader;
			
		}
		
		public function getMoudule(url:String):ModuleLoader
		{
			return _moudules[url];			
		}
		
		private function currentApplication():Object 
		{
			var app:Object = FlexGlobals.topLevelApplication;
			if (app == null) {
				// Flex 4 spark application
				var flexGlobals:Class = getDefinitionByName("mx.core.FlexGlobals") as Class;
				app = flexGlobals.topLevelApplication;
			}
			return app;
		}
		
		
		public function observer(eventObj:*, func:Function, autoRemove:Boolean=false, obj:Object=null):void 
		{
			var str:String=(new Error()).getStackTrace();
			if(str)
			{
				str=str.split("at ")[2];
				log.info("监视:"+eventObj+"{"+str+"}");
			}
			if(eventObj==null)
				log.warn("event can not be null string");
			else
				if(eventObj is String)
				{
					if (eventObj!="")
					{
						if(_newListeners[eventObj]!=null)
						{
							
							var objFuns:Array=_newListeners[eventObj].funcs;
							
							log.info("event:"+eventObj+" already have "+objFuns.length+" observers");
							_newListeners[eventObj].funcs.push(func);
							_newListeners[eventObj].objs.push(obj);
							_newListeners[eventObj].autoRemoves.push(autoRemove);
							
						}
						else
						{
							var _obj:Object=new Object();
							_obj.objs=new Array();
							_obj.objs.push(obj);
							_obj.funcs=new Array();
							_obj.funcs.push(func);
							_obj.autoRemoves=new Array();
							_obj.autoRemoves.push(autoRemove);
							_newListeners[eventObj]=_obj;
						}
					}
					else
						log.warn("event can not be null string");
				}
				else
					if((eventObj is Event) || (eventObj is Class))
					{
						var className:String = getQualifiedClassName(eventObj);
						if(_newListeners[className]!=null)
						{
							var objFuns1:Array=_newListeners[className].funcs;
							
							log.info("event class name:"+className+" already have "+objFuns1.length+" observers");
							_newListeners[className].funcs.push(func);
							_newListeners[className].objs.push(obj);
							_newListeners[className].autoRemoves.push(autoRemove);
							
						}
						else
						{
							var _obj1:Object=new Object();
							_obj1.objs=new Array();
							_obj1.objs.push(obj);
							_obj1.funcs=new Array();
							_obj1.funcs.push(func);
							_obj1.autoRemoves=new Array();
							_obj1.autoRemoves.push(autoRemove);
							_newListeners[className]=_obj1;
						}
						
					}
					else
						log.warn("event can not be non Event or Class");
		}
		
		public function deleteEvent(eventObj:*):void {
			if(eventObj==null)
				log.warn("event can not be null string");
			else
				if(eventObj is String)
				{
					if(_newListeners[eventObj]!=null)
					{
						delete _newListeners[eventObj];
						log.info("删除:"+eventObj);
					}
				}
				else
					if((eventObj is Event) || (eventObj is Class))
					{
						var className:String = getQualifiedClassName(eventObj);
						if(_newListeners[className]!=null)
						{
							delete _newListeners[className];
							log.info("删除:"+eventObj);
						}
						
					}
					else
						log.warn("event can not be non Event or Class");
		}
		
		public function raiseEvent(eventObj:*,...params):Boolean {
			if (null == eventObj)
				return false;
			return dispatchEvent(new SystemEvent(SystemEvent.SYSTEM_EVENT, eventObj, params));
		}
		
		public function raiseEventAndRun(eventObj:*,...params):Boolean {
			if (null == eventObj)
				return false;
			listenSystemEvent(new SystemEvent(SystemEvent.SYSTEM_EVENT, eventObj, params));
			return true;
		}
		
		private function listenSystemEvent(event:SystemEvent):void {
			var _v:Object=null;
			var eventName:String="";
			if(event.eventObj is Event)
			{
				var className:String = getQualifiedClassName(event.eventObj);
				eventName=className;			
			}
			else
				if(event.eventObj is String)
					eventName=event.eventObj;
				else
				{
					log.warn("raised Event should be a String or Event type");
					return;
				}
			if(eventName=="")
			{
				log.warn("event name can not be null");
				return;
			}
			_v=_newListeners[eventName];
			
			if(_v!=null)
			{
				if(_v.hasOwnProperty("funcs"))
				{
					var funcs:Array=_v.funcs;
					var j:int=0;
					for(var i:int=0;i<funcs.length;i++)
					{
						log.debug("调用:"+event.eventObj)
						var func:Function=funcs[i];
						if(event.eventObj is String)
						{
							if(_v.hasOwnProperty("objs"))
							{
								var _obj:Object=_v.objs[i];
								func.apply(_obj, event.params);
							}
							else
								func.apply(null, event.params);
						}
						else
							if(event.eventObj is Event)
							{
								var clonedEvent:Object = null;
								if (event.eventObj is IExternalizable)
									clonedEvent = ObjectUtil.copy(event.eventObj);
								else
									clonedEvent = event.eventObj.clone();
								var targetParams:Array = new Array();
								targetParams.push(clonedEvent);
								if(_v.hasOwnProperty("objs"))
								{
									var _obj1:Object=_v.objs[i];
									
									func.apply(_obj1, targetParams.concat(event.params));
								}
								else
									func.apply(null, targetParams);
							}
							else
								log.warn(eventName+" is not String or Event");
						if(_v.hasOwnProperty("autoRemoves"))
						{
							var auto:Boolean=_v.autoRemoves[i];
							if(auto)
							{
								log.info("自动删除:"+event.eventObj+"-"+j)
								j++;
								delete _v.funcs[i];
								delete _v.objs[i];
								delete _v.autoRemoves[i];
								_v.funcs.splice(i,1);
								_v.objs.splice(i,1);
								_v.autoRemoves.splice(i,1);
								i--;
							}
						}
					}
					if(funcs.length>1)
						log.info(eventName+" have muti observer:"+funcs.length);
					if(funcs.length==0)
						delete _newListeners[eventName];
				}
				else
				{
					log.warn(eventName+" have not functions");
					deleteEvent(eventName);
				}
			}
			else
			{
				log.warn(eventName+" have not observer");
			}
		}
		
	}
}