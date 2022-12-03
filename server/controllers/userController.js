const User = require("../models/user");
//const { model } = require("mongoose");
const express = require("express");
const jwt = require('jsonwebtoken');
require("dotenv").config();
authRouter = express.Router()

const signup = async (req , res) =>{
                                      //Existing user check 
                                      //user crestion
                                      // jason web token creation
                                  
                                        //      \|/ http://localhost:7375/api/signup .post
      try {
            const { name, email, profilePic } = req.body;
                                             // req.body implements that the name ,email ,profilepic is given by user
                                             //if the user already exists then get that user
            //let user = await User.findOne({ email });
        let user = await User.findOne({ email: email });
        
            if (!user) {
              user = new User({
                email:email,
                profilePic:profilePic,
                name:name,
              });
              user = await user.save();
            }
      //   const token = jwt.sign({ id: user._id }, "passwordKey");
       const token = jwt.sign({ id: user._id} , process.env.JWTPRIVATEKEY);  
        //res.json({ user : user, token:token });
         res.json({ user : user, token:token });
          //res.json({ user : user});
          } catch (e) {
            res.status(500).json({ error: e.message });
          }

}
const signin = (req , res) =>{
      
}

module.exports = {signin,signup};