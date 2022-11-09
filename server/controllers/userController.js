

//const userModel = require("..models/user") ;
//const { model } = require("mongoose");

const signup = async (req , res) =>{
      try {
            const { name, email, profilePic } = req.body;
        
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
         //const token = jwt.sign({ id: user._id }, "passwordKey");
        //   res.json({ user : user, token });
          res.json({ user : user});
          } catch (e) {
            res.status(500).json({ error: e.message });
          }

}


const signin = (req , res) =>{

      
}

module.exports = {signin,signup};