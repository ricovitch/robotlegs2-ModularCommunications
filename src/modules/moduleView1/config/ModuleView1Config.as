package modules.moduleView1.config
{
	import flash.display.DisplayObjectContainer;
	
	import mx.events.FlexEvent;
	
	import spark.modules.Module;
	
	import modules.moduleView1.views.ModuleView1;
	import modules.moduleView1.views.ModuleView1Mediator;
	
	import org.swiftsuspenders.Injector;
	
	import robotlegs.bender.bundles.mvcs.MVCSBundle;
	import robotlegs.bender.extensions.contextView.ContextView;
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.api.LogLevel;
	import robotlegs.bender.framework.impl.Context;
	
	public class ModuleView1Config
	{
		public var context:IContext;
		public var injector:Injector;
		
		private var _mediatorMap:IMediatorMap;
		private var _contextView:DisplayObjectContainer;
		
		public function ModuleView1Config( contextView:DisplayObjectContainer )
		{
			_contextView = contextView;
			startConfiguring();
		}
		
		public function startConfiguring():void
		{
			context = new Context()
				.install( MVCSBundle )
				.configure( new ContextView (_contextView) );
			
			context.logLevel = LogLevel.DEBUG;
			
			injector = context.injector;
			_mediatorMap = injector.getInstance( IMediatorMap );
			
			configureMediators();
		}
		
		private function configureMediators():void
		{
			_mediatorMap.map( ModuleView1 ).toMediator( ModuleView1Mediator );
			_mediatorMap.mediate( _contextView );
		}
	}
}