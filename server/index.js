const express = require("express");
const mongoose = require("mongoose");
const authRouter = require("./routes/auth");

const PORT = process.env.PORT || 7375

const app = express();

app.use(express.json());
app.use(authRouter);

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

