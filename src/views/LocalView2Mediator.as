package views
{
	import actions.TextMessageEvent;
	
	import flash.utils.Dictionary;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	import robotlegs.bender.framework.api.ILogger;
	
	public class LocalView2Mediator extends Mediator
	{
		[Inject]
		public var view:LocalView2;
		
		[Inject]
		public var logger:ILogger;
		
		[Inject(name="CommunicationChannels")]
		public var dispatchChannel:Dictionary;
		
		override public function initialize():void
		{
			logger.info( "Local View 2 Initialized" );
			
			addViewListener( TextMessageEvent.TEXT_MESSAGE, sendMessageHandler, TextMessageEvent );
			eventMap.mapListener( dispatchChannel[ "global" ], TextMessageEvent.TEXT_MESSAGE, messageReceived, TextMessageEvent );
		}
		
		private function sendMessageHandler( event:TextMessageEvent ):void
		{
			dispatchChannel[ event.channel ].dispatchEvent( event );
		}
		
		private function messageReceived( event:TextMessageEvent ):void
		{
			view.messageList.addItem( event.message );
		}
	}
}