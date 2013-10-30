import js.node.SocketIo;
import js.npm.connect.Static;
import js.npm.Express;
import js.npm.express.*;
import js.npm.Jade;

class ExpressSocket  {

	var app : Express;
	var io : SocketIoManager;
	var chatLog: ChatLog;
	
	function new( port : Int ){

		js.npm.Mongoose._.connect( js.Node.process.env.MONGOHQ_URL );

		chatLog = new ChatLog();

		app = new Express();

		app.set("views" , js.Node.__dirname + "/templates" );
		app.set("view engine" , "jade" );

		app.use( new Static( js.Node.__dirname + "/public" ) );
		app.get("*",handle);
		
		var http = js.node.Http.createServer(app);

		io = js.Node.require('socket.io').listen( http );
		io.sockets.on("connection", function( socket : SocketNamespace ){
			socket.on("chat", function(val : ChatIn ){
				//trace("recu",val);
				var out : ChatOut = {
					text : val.text,
					user : socket.id,
					color : "#f00"
				};

				chatLog.add( {
					user : out.user,
					text : out.text,
					date : Date.now(),
					color : out.color
				}, function(){
					io.sockets.emit("chat", out );	
				});

				
			});
			//trace("new connection");
			//io.sockets.emit( "coucou" , socket.id );
		});

		var port = 9000;

		if( js.Node.process.env.PORT != null ){
			port = js.Node.process.env.PORT;
		}

		http.listen( port );
	}

	function handle( req : Request , res : Response ){
		chatLog.history(function(logs){

			res.render( 'index' , { messages : logs } );

		});
	}
	
	static function main(){
		new ExpressSocket(9000);
	}
	
}