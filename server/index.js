const cors=require("cors")
const express=require("express")
const app=express()
const db=require("./database/index")
const PORT=3000
//* middleWears
app.use(express.json());
app.use(express.urlencoded({extended:true}))
app.use(cors({origin:true}));

//*Routes
const eleveRoute=require("./router/eleve");

//*Main Route
app.use("/eleve",eleveRoute)

//*DataBase connection 
app.listen(PORT, ()=> {
    console.log(`Server Listening on port http://localhost:${PORT}`);
  });

