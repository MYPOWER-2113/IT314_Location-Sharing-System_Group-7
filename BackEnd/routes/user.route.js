const express = require('express')
const User = require('../models/user.model')
const router = express.Router()
const jwt = require("jsonwebtoken")

router.post('/signup',async(req,res)=>{
    const {email,password} = req.body;

  try {

    if(await User.findOne({email}))
    {
      res.status(400).json({
                message:'Email is already registered'
            })   
    }
    else
    {
        const userDoc = await User.create({
        email,
        password,
        });
        res.json(userDoc);
    }
    
  } catch (e) {
    res.status(500).json({error : e.message});
  }
    
})


router.post('/signin', async(req,res)=>{
  try{const {email,password} = req.body;
  const userDoc = await User.findOne({email});

  if (userDoc) {
    if (password == userDoc.password) {
        const token = jwt.sign({id:userDoc._id}, "passwordKey");
        res.json({token, ...userDoc._doc})
    } 
    else {
      res.status(400).json({msg : "Password is Wrong"});
    }
  } 
  else {
     return res.status(400).json({msg : "User with this email does not exist !"});
  }}
  catch(e)
  {
    res.status(500).json({error : e.message});
  }
})
module.exports = router