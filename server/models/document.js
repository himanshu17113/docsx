const mongoose = require('mongoose');

const docmentSchema = new mongoose.Schema({
 
  uid: {
            type: String,
            required: true
          },


 createdat: {
            type: Number,
            required: true
          },

  title: {
    type: String,
    required: true
  },
  
  content : {
    type: Array,
    default:[]
  },

  
});

const Docment = mongoose.model('Docment', docmentSchema);

module.exports = Docment;
