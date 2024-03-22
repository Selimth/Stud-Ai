const eleve = require('../database/model/eleve');

module.exports={

    getAllStudents:function(req,res){
        eleve.getAll(function(err,result){
            if (err) res.status(500).send(err);
            else res.json(result);
        })
    }

}
