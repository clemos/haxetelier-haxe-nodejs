import js.node.SocketIo;
import js.npm.connect.Static;
import js.npm.Express;
import js.npm.express.*;
import js.npm.Jade;

class ExpressSocket extends Express {

	var app : Express;
	var io : SocketIoManager;

	function new( port : Int ){
		app = new Express();

		app.set("views" , js.Node.__dirname + "/templates" );
		app.set("view engine" , "jade" );

		app.use( new Static( js.Node.__dirname + "/public" ) );
		app.get("*",handle);
		
		var http = js.node.Http.createServer(app);

		io = js.Node.require('socket.io').listen( http );
		io.sockets.on("connection", function( socket : SocketNamespace ){
			socket.on("chat", function(val : ChatIn ){
				trace("recu",val);
				var out : ChatOut = {
					text : val.text,
					user : socket.id,
					color : "#f00"
				};
				io.sockets.emit("chat", out );
			});
			//trace("new connection");
			//io.sockets.emit( "coucou" , socket.id );
		});

		http.listen(9000);
	}

	function handle( req : Request , res : Response ){
		var url = req.path;
		res.render( 'index' );
	}
	
	static function main(){
		new ExpressSocket(9000);
	}
	
}