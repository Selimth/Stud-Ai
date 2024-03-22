const conn = require('../index');

module.exports={

    getAll:function (callback){
        let query="SELECT * FROM eleve";
        conn.query(query,function(error,result){
            callback(error,result)
        })
    }

}
