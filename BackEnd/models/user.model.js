const mongoose = require('mongoose')
const Schema = mongoose.Schema

const userSchema = mongoose.Schema({
  name: {
    required: true,
    type: String,
    trim: true,
  },
  email: {
    required: true,
    type: String,
    trim: true,
    validate: {
      validator: (value) => {
        const regex =
          /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
        return value.match(regex);
      },
      message: "Please enter a valid email address",
    },
  },
  password: {
    required: true,
    type: String,
  },
  number:{
    required: true,
    type: String,
    trim: true,
    validate: {
      validator: (value) => {
        const regex =
          /^([0|\+[0-9]{1,5})?([7-9][0-9]{9})$/i;
        return value.match(regex);
      },
      message: "Please enter a valid mobile number",
    },
  },
  SOSnumber:{
    type: Array,
  }
});

module.exports = mongoose.model('User',userSchema)