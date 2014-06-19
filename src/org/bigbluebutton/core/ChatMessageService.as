package org.bigbluebutton.core
{
	import org.bigbluebutton.model.IConferenceParameters;
	import org.bigbluebutton.model.IMessageListener;
	import org.bigbluebutton.model.IUserSession;
	import org.bigbluebutton.model.User;
	import org.bigbluebutton.model.chat.ChatMessageVO;
	import org.bigbluebutton.model.chat.IChatMessagesSession;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;
	
	public class ChatMessageService implements IChatMessageService
	{	
		[Inject]
		public var userSession: IUserSession;
		
		[Inject]
		public var conferenceParameters: IConferenceParameters;
		
		[Inject]
		public var chatMessagesSession:IChatMessagesSession;
		
		public var chatMessageSender: ChatMessageSender;
		public var chatMessageReceiver: ChatMessageReceiver;
		
		private var _sendPublicMessageOnSucessSignal:ISignal = new Signal;
		private var _sendPublicMessageOnFailureSignal:ISignal = new Signal;
		
		private var _sendPrivateMessageOnSucessSignal:ISignal = new Signal;
		private var _sendPrivateMessageOnFailureSignal:ISignal = new Signal;
		
		public function get sendPublicMessageOnSucessSignal():ISignal {
			return _sendPublicMessageOnSucessSignal;
		}
		
		public function get sendPublicMessageOnFailureSignal():ISignal {
			return _sendPublicMessageOnFailureSignal;
		}
		
		public function get sendPrivateMessageOnSucessSignal():ISignal {
			return _sendPrivateMessageOnSucessSignal;
		}

		public function get sendPrivateMessageOnFailureSignal():ISignal {
			return _sendPrivateMessageOnFailureSignal;
		}
		
		public function ChatMessageService() {
			chatMessageSender = new ChatMessageSender;
			chatMessageReceiver = new ChatMessageReceiver;
		}
		
		public function setupMessageSenderReceiver():void {
			chatMessageSender.userSession = userSession;
			chatMessageSender.chatMessagesSession = chatMessagesSession;
			chatMessageSender.chatMessageService = this;
			
			chatMessageReceiver.userSession = userSession;
			chatMessageReceiver.chatMessagesSession = chatMessagesSession;
			
			userSession.mainConnection.addMessageListener(chatMessageReceiver as IMessageListener);
		}
		
		public function getPublicChatMessages():void {
			chatMessageSender.getPublicChatMessages();
		}
		
		public function sendPublicMessage(message:ChatMessageVO):void {
			chatMessageSender.sendPublicMessage(message);
		}
		
		public function sendPrivateMessage(message:ChatMessageVO):void {
			chatMessageSender.sendPrivateMessage(message);
		}
		
		/**
		 * Creates new instance of ChatMessageVO with Welcome message as message string
		 * and imitates new public message being sent
		 **/ 
		public function sendWelcomeMessage():void {
			
			// retrieve welcome message from conference parameters
			var welcome:String = conferenceParameters.welcome;
			
			if (welcome != "") {   		
				var msg:ChatMessageVO = new ChatMessageVO();
				msg.chatType = "PUBLIC_CHAT"
				msg.fromUserID = " ";
				msg.fromUsername = " ";
				msg.fromColor = "86187";
				msg.fromLang = "en";
				msg.fromTime = new Date().time;
				msg.fromTimezoneOffset = new Date().timezoneOffset;
				msg.toUserID = " ";
				msg.toUsername = " ";
				msg.message = welcome;
				
				// imitate new public message being sent
				chatMessageReceiver.onMessage("ChatReceivePublicMessageCommand", msg);			
			}
		}
	}
}