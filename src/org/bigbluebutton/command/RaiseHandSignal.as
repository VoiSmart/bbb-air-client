package org.bigbluebutton.command
{
	import org.osflash.signals.Signal;

	public class RaiseHandSignal extends Signal
	{
		public function RaiseHandSignal()
		{
			/**
			 * @1 userId 
			 * @2 handRaised
			 */
			super(String, Boolean);
		}
	}
}