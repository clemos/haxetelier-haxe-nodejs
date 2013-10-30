import js.node.SocketIoClient;

class Client {
	
	static function main(){
		var socket = Io.connect();
		var text = new js.JQuery(".input-text");
		var form = new js.JQuery("form");
		var messages = new js.JQuery(".messages");
		
		form.on("submit",function(e){
			
			var txt = text.val();
			if( txt == null || txt == '' )
				return;

			var val : ChatIn = {
				text : txt
			};

			text.val('');

			socket.emit("chat", val);
		});

		socket.on('chat', function( val : ChatOut ){

			messages.append("<div style='color:"+val.color+"'><b>"+val.user+"</b>"+val.text+"</div>");
		});

	}
}