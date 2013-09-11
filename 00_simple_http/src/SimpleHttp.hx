
class SimpleHttp {
	
	static function main(){
		var server = js.node.Http.createServer(function(req,res){

			var url = req.url;
			

			res.write('Hello $url!');
			res.end();
		});

		server.listen(9000);
	}
	
}