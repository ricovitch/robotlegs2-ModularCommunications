package modules.moduleView1.views
{
	import actions.TextMessageEvent;
	
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	
	import org.swiftsuspenders.Injector;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	import robotlegs.bender.framework.api.ILogger;
	
	public class ModuleView1Mediator extends Mediator
	{
		[Inject]
		public var view:ModuleView1;
		
		[Inject]
		public var logger:ILogger;
		
		[Inject(name="CommunicationChannels")]
		public var dispatchChannel:Dictionary;
		
		override public function initialize():void
		{
			logger.info( "Module View 1 Initialized" );
			
			addViewListener( TextMessageEvent.TEXT_MESSAGE, sendMessageHandler, TextMessageEvent );
			
			EventDispatcher( dispatchChannel[ "global" ] ).addEventListener( TextMessageEvent.TEXT_MESSAGE, messageReceived );
			EventDispatcher( dispatchChannel[ "moduleOnly" ] ).addEventListener( TextMessageEvent.TEXT_MESSAGE, messageReceived );
			EventDispatcher( dispatchChannel[ "toModule1" ] ).addEventListener( TextMessageEvent.TEXT_MESSAGE, messageReceived );
		}
		
		private function sendMessageHandler( event:TextMessageEvent ):void
		{
			EventDispatcher( dispatchChannel[ event.channel ] ).dispatchEvent( event );
		}
		
		private function messageReceived( event:TextMessageEvent ):void
		{
			view.messageList.addItem( event.message );
		}
	}
}