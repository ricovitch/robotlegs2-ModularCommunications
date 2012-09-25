package config
{
	import flash.display.DisplayObjectContainer;
	import flash.events.IEventDispatcher;
	
	import org.swiftsuspenders.Injector;
	
	import robotlegs.bender.bundles.mvcs.MVCSBundle;
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
	import robotlegs.bender.extensions.scopedEventDispatcher.ScopedEventDispatcherExtension;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.api.LogLevel;
	import robotlegs.bender.framework.impl.Context;
	
	import views.LocalView1;
	import views.LocalView1Mediator;
	import views.LocalView2;
	import views.LocalView2Mediator;

	public class RL2ModularCommunicationsConfig
	{
		public var context:IContext;
		public var injector:Injector;
		
		private var _mediatorMap:IMediatorMap;
		private var _eventDispatcher:IEventDispatcher;
		
		private var _contextView:DisplayObjectContainer;
		
		public function RL2ModularCommunicationsConfig( contextView:DisplayObjectContainer )
		{
			_contextView = contextView;
			startConfiguration();
		}
		
		private function startConfiguration():void
		{
			context = new Context()
				.extend( MVCSBundle )
				.extend( new ScopedEventDispatcherExtension( "global", "moduleOnly", "toModule1", "toModule2" ) )
				.configure( _contextView );
			
			context.logLevel = LogLevel.DEBUG;
			
			injector = context.injector;
			_eventDispatcher = injector.getInstance( IEventDispatcher );
			_mediatorMap = injector.getInstance( IMediatorMap );
			
			mapMappingCommands();
		}
		
		private function mapMappingCommands():void
		{
			_mediatorMap.map( LocalView1 ).toMediator( LocalView1Mediator );
			_mediatorMap.map( LocalView2 ).toMediator( LocalView2Mediator );
		}
	}
}