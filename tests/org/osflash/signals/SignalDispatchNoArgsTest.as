package org.osflash.signals
{
	import asunit.asserts.*;

	import asunit4.async.addAsync;

	public class SignalDispatchNoArgsTest
	{
		public var completed:Signal;

		[Before]
		public function setUp():void
		{
			completed = new Signal();
		}

		[After]
		public function tearDown():void
		{
			completed.removeAll();
			completed = null;
		}
		//////
		[Test(async)]
		public function dispatch_no_args_should_call_listener_with_no_args():void
		{
			completed.add( addAsync(onCompleted, 10) );
			completed.dispatch();
		}
		
		private function onCompleted():void
		{
			assertEquals(0, arguments.length);
		}
		//////
		[Test(async)]
		public function addOnce_in_handler_and_dispatch_should_call_new_listener():void
		{
			completed.addOnce( addAsync(addOnceInHandler, 10) );
			completed.dispatch();
		}
		
		protected function addOnceInHandler():void
		{
			completed.addOnce( addAsync(secondAddOnceListener, 10) );
			completed.dispatch();
		}
		
		protected function secondAddOnceListener():void
		{
		}
	}
}
