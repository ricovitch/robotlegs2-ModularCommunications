package views
{
	import actions.TextMessageEvent;
	
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	import robotlegs.bender.framework.api.ILogger;
	
	public class LocalView2Mediator extends Mediator
	{
		[Inject]
		public var view:LocalView2;
		
		[Inject]
		public var logger:ILogger;
		
		[Inject(name="global")]
		public var globalDispatcher:IEventDispatcher;
		
		[Inject(name="moduleOnly")]
		public var moduleOnlyDispatcher:IEventDispatcher;
		
		[Inject(name="toModule1")]
		public var toModule1Dispatcher:IEventDispatcher;
		
		[Inject(name="toModule2")]
		public var toModule2Dispatcher:IEventDispatcher;
		
		override public function initialize():void
		{
			logger.info( "Local View 2 Initialized" );
			eventMap.mapListener( view.sendMessage, MouseEvent.CLICK, sendMessageHandler, MouseEvent );
			
			globalDispatcher.addEventListener( TextMessageEvent.TEXT_MESSAGE, messageReceived );
		}
		
		private function sendMessageHandler( event:MouseEvent ):void
		{
			switch( view.sendChannel.selectedItem )
			{
				case "global":
					globalDispatcher.dispatchEvent( new TextMessageEvent( TextMessageEvent.TEXT_MESSAGE, "Local View 2: Hello!!" ) );
					break;
				
				case "moduleOnly":
					moduleOnlyDispatcher.dispatchEvent( new TextMessageEvent( TextMessageEvent.TEXT_MESSAGE, "Local View 2: Hello!!" ) );
					break;
				
				case "toModule1":
					toModule1Dispatcher.dispatchEvent( new TextMessageEvent( TextMessageEvent.TEXT_MESSAGE, "Local View 2: Hello!!" ) );
					break;
				
				case "toModule2":
					toModule2Dispatcher.dispatchEvent( new TextMessageEvent( TextMessageEvent.TEXT_MESSAGE, "Local View 2: Hello!!" ) );
					break;
			}
		}
		
		private function messageReceived( event:TextMessageEvent ):void
		{
			view.messageList.addItem( event.message );
		}
	}
}