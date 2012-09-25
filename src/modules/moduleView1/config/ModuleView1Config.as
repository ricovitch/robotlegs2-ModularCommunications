package modules.moduleView1.config
{
	import modules.moduleView1.views.ModuleView1;
	import modules.moduleView1.views.ModuleView1Mediator;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.IEventDispatcher;
	
	import mx.events.FlexEvent;
	
	import org.swiftsuspenders.Injector;
	
	import robotlegs.bender.bundles.mvcs.MVCSBundle;
	import robotlegs.bender.extensions.contextView.ContextViewExtension;
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
	import robotlegs.bender.extensions.modularity.ModularityExtension;
	import robotlegs.bender.extensions.scopedEventDispatcher.ScopedEventDispatcherExtension;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.api.LogLevel;
	import robotlegs.bender.framework.impl.Context;
	
	import spark.modules.Module;

	public class ModuleView1Config
	{
		public var context:IContext;
		public var injector:Injector;
		
		private var _mediatorMap:IMediatorMap;
		private var _eventDispatcher:IEventDispatcher;
		
		private var _contextView:DisplayObjectContainer;
		
		public function ModuleView1Config( contextView:DisplayObjectContainer )
		{
			_contextView = contextView;
			startConfiguring();
		}
		
		public function startConfiguring():void
		{
			context = new Context()
				.extend( MVCSBundle )
				.extend( ContextViewExtension )
				.extend( ModularityExtension )
				.extend( new ScopedEventDispatcherExtension( "global", "moduleOnly", "toModule1" ) )
				.configure( _contextView );
			
			context.logLevel = LogLevel.DEBUG;
			
			injector = context.injector;
			_eventDispatcher = injector.getInstance( IEventDispatcher );
			_mediatorMap = injector.getInstance( IMediatorMap );
			
			mapMappingCommands();
		}
		
		private function mapMappingCommands():void
		{
			_mediatorMap.map( ModuleView1 ).toMediator( ModuleView1Mediator );
			_mediatorMap.mediate( _contextView );
		}
	}
}