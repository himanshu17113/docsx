const express = require("express");
//const { docs } = require("../controllers/docController");
const auth = require("../middlewares/auth");
const Docment = require("../models/document");

docRouter = express.Router()

docRouter.post("/doc/create", auth, async (req, res) => {
try {
      const  {createdat} = req.body
       let document = new Docment({
                uid: req.user,
          createdat:createdat,
              title: "untitled docment"
        });
            document = await document.save()
            
        res.json(document)

} catch (e) {
    res.status(500).json({ error: e.message });
}
});
//docRouter.post("doc/create",auth,docs)

module.exports = docRouter

