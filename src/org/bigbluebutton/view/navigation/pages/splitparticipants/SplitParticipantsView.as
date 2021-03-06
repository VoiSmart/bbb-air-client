package org.bigbluebutton.view.navigation.pages.splitparticipants {
	
	import flash.events.MouseEvent;
	import spark.components.Button;
	import spark.components.Group;
	import spark.components.Label;
	import spark.components.List;
	import spark.components.RadioButtonGroup;
	import spark.components.ViewNavigator;
	
	public class SplitParticipantsView extends SplitParticipantsViewBase implements ISplitParticipantsView {
		override protected function childrenCreated():void {
			super.childrenCreated();
		}
		
		public function dispose():void {
		}
		
		public function get participantsList():ViewNavigator {
			return participantslist0;
		}
		
		public function get participantDetails():ViewNavigator {
			return participantdetails0;
		}
	}
}
