
class SimpleExpress {
	
	static function main(){
		var server = new js.npm.Express();
		server.get( "*" , function(req,res){
			var url = req.path;
			res.send('Hello $url');
		} );
		server.listen(9000);
	}
	
}