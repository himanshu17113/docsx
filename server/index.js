const express = require("express");
 cors = require("cors");
const mongoose = require("mongoose");
const authRouter = require("./routes/auth");
const docRouter = require("./routes/doc")
require("dotenv").config();

const PORT = process.env.PORT || 7375
//    ^ saving our port number in env for security
 app = express();
app.use(cors());
app.use(express.json());
  // ^ it converts req.body into jason
app.use(authRouter);
app.use(docRouter);
//connecting our mongo data base to a server
const DB =  "mongodb+srv://Himanshu:m7037543555@cluster0.odnwatq.mongodb.net/?retryWrites=true&w=majority";

mongoose.connect(DB).then( () =>{

    console.log("===>Connection is Succesful<===");
   
} ).catch( (error) => {

    console.log("===>Connection is UnSuccesful<===");
    console.log(error);
    
});


app.listen(
    PORT,"0.0.0.0", ()=> {
       console.log(`connected at the port ${PORT}`);
       console.log("hey this changing");
    }
);

