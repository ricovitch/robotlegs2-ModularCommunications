package modules.moduleView2.config
{
	import flash.display.DisplayObjectContainer;
	
	import modules.moduleView2.views.ModuleView2;
	import modules.moduleView2.views.ModuleView2Mediator;
	
	import mx.events.FlexEvent;
	
	import org.swiftsuspenders.Injector;
	
	import robotlegs.bender.bundles.mvcs.MVCSBundle;
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.api.LogLevel;
	import robotlegs.bender.framework.impl.Context;
	
	public class ModuleView2Config
	{
		public var context:IContext;
		public var injector:Injector;
		
		private var _mediatorMap:IMediatorMap;
		private var _contextView:DisplayObjectContainer;
		
		public function ModuleView2Config( contextView:DisplayObjectContainer )
		{
			_contextView = contextView;
			startConfiguring();
		}
		
		public function startConfiguring():void
		{
			context = new Context()
				.extend( MVCSBundle )
				.configure( _contextView );
			
			context.logLevel = LogLevel.DEBUG;
			
			injector = context.injector;
			_mediatorMap = injector.getInstance( IMediatorMap );
			
			configureMediators();
		}
		
		private function configureMediators():void
		{
			_mediatorMap.map( ModuleView2 ).toMediator( ModuleView2Mediator );
			_mediatorMap.mediate( _contextView );
		}
	}
}