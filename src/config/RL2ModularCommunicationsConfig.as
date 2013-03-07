package config
{
	import flash.display.DisplayObjectContainer;
	import flash.events.IEventDispatcher;
	import flash.utils.Dictionary;
	
	import org.swiftsuspenders.Injector;
	
	import robotlegs.bender.bundles.mvcs.MVCSBundle;
	import robotlegs.bender.extensions.contextView.ContextView;
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
		
		private var _contextView:DisplayObjectContainer;
		
		public function RL2ModularCommunicationsConfig( contextView:DisplayObjectContainer )
		{
			_contextView = contextView;
			startConfiguration();
		}
		
		private function startConfiguration():void
		{
			context = new Context()
				.install( MVCSBundle )
				.install( new ScopedEventDispatcherExtension( "global", "moduleOnly", "toModule1", "toModule2" ) )
				.configure( new ContextView(_contextView) );
			
			context.logLevel = LogLevel.DEBUG;
			context.afterInitializing( afterInitializing );
			
			injector = context.injector;
			_mediatorMap = injector.getInstance( IMediatorMap );
			
			configureMediators();
		}
		
		private function configureMediators():void
		{
			_mediatorMap.map( LocalView1 ).toMediator( LocalView1Mediator );
			_mediatorMap.map( LocalView2 ).toMediator( LocalView2Mediator );
		}
		
		private function afterInitializing():void
		{
			var communicationChannels:Dictionary = new Dictionary();
				communicationChannels[ "global" ] = injector.getInstance( IEventDispatcher, "global" );
				communicationChannels[ "moduleOnly" ] = injector.getInstance( IEventDispatcher, "moduleOnly" );
				communicationChannels[ "toModule1" ] = injector.getInstance( IEventDispatcher, "toModule1" );
				communicationChannels[ "toModule2" ] = injector.getInstance( IEventDispatcher, "toModule2" );
			
			injector.map( Dictionary, "CommunicationChannels" ).toValue( communicationChannels );
		}
	}
}