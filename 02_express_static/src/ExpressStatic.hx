import js.npm.connect.Static;
import js.npm.Express;


import js.npm.express.*;

class ExpressStatic {

	var app : Express;

	function new( port : Int ){
		app = new Express();
		app.use( new Static( js.Node.__dirname + "/public" ) );
		app.get("*",handle);
		app.listen( port );
	}
	function handle( req : Request , res : Response ){
		var url = req.path;
		res.send( '<img src="/image.png">' );
	}
	
	static function main(){
		new ExpressStatic(9000);
	}
	
}