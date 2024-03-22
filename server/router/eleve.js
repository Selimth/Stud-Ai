const express = require("express")
const router = express.Router()

const {getAllStudents}=require("../controller/eleve");

router.get("/getAll",getAllStudents);


module.exports = router;


