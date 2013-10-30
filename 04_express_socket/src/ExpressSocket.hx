import js.node.SocketIo;
import js.npm.connect.CookieParser;
import js.npm.connect.Static;
import js.npm.Express;
import js.npm.express.*;
import js.npm.Jade;

import js.Node.*;

using js.npm.connect.Session;

class ExpressSocket  {

	var app : Express;
	var io : SocketIoManager;
	var chatLog: ChatLog;
	
	function new(){

		js.npm.Mongoose._.connect( process.env.MONGOHQ_URL );

		chatLog = new ChatLog();

		app = new Express();
		app.use( new CookieParser('toto') );
		app.use( new Session( { secret : 'toto' } ) );

		app.set("views" , __dirname + "/templates" );
		app.set("view engine" , "jade" );

		app.use( new Static( __dirname + "/public" ) );
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

		/*var port = 9000;

		if( js.Node.process.env.PORT != null ){
			port = js.Node.process.env.PORT;
		}*/

		http.listen( untyped ( process.env.PORT || 9000 ) );
	}

	function handle( req : Request , res : Response ){

		var session = req.session();

		if( session.test == null ){
			session.test = 0;
		}
		session.test++;

		chatLog.history(function(logs){

			res.render( 'index' , { messages : logs , session : session } );

		});
	}
	
	static function main(){
		new ExpressSocket();
	}
	
}