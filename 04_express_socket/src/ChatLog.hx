import js.npm.mongoose.Schema;

class ChatLog {

	var schema : Schema;
	var model : js.npm.mongoose.Model.Models<Dynamic>;

	public function new(){

		schema = new Schema({
			user : String,
			text : String,
			date : Date,
			color : String
		});

		model = js.npm.Mongoose._.model( 'ChatLog', schema );

	}

	public function add( log : Dynamic , cb ){
		model.create( log , function(err,_created){
			cb();
		} );

	}

	public function history( cb ){
		model.find({})
			.sort('date')
			.exec(function(err,logs){

				if( err != null ){
					trace(err);
					cb([]);
				}
				cb(logs);
			});
	}



}