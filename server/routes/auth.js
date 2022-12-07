const express = require("express");
const { signup } = require("../controllers/userController");
const auth = require("../middlewares/auth");
const User = require("../models/user");

authRouter = express.Router()

// authRouter.post("/api/signup", async (req, res) => {
//   try {
//     const { name, email, profilePic } = req.body;

//     //let user = await User.findOne({ email });
// let user = await User.findOne({ email: email });

//     if (!user) {
//       user = new User({
//         email:email,
//         profilePic:profilePic,
//         name:name,
//       });
//       user = await user.save();
//     }
//  //const token = jwt.sign({ id: user._id }, "passwordKey");
// //   res.json({ user : user, token });
//   res.json({ user : user});
//   } catch (e) {
//     res.status(500).json({ error: e.message });
//   }




// });

authRouter.post("/api/signup", signup);


  authRouter.get("/", auth, async (req, res) => {
 
try {
         const user = await User.findById(req.user);
        res.json({user: user, token: req.token });
    } catch (error) {

   res.status(200).json({ 
    // hjbhjbhjb
    error: error.message
   });
}  
      });
  



module.exports = authRouter;