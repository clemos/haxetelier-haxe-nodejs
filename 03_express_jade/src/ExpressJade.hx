import js.npm.connect.Static;
import js.npm.Express;
import js.npm.express.*;
import js.npm.Jade;

class ExpressJade {

	var app : Express;

	function new( port : Int ){
		app = new Express();

		app.set("views" , js.Node.__dirname + "/templates" );
		app.set("view engine" , "jade" );

		app.use( new Static( js.Node.__dirname + "/public" ) );
		app.get("*",handle);
		app.listen( port );
	}
	function handle( req : Request , res : Response ){
		var url = req.path;
		res.render( 'index' , { url : url } );
		
	}
	
	static function main(){
		new ExpressJade(9000);
	}
	
}