const express = require('express')
const User = require('../models/user.model')
const router = express.Router()


router.post('/signup',async(req,res)=>{
    const {email,password} = req.body;

  try {

    if(await User.findOne({email}))
    {
      res.json({
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
    res.status(422).json(e);
  }
    
})


router.post('/signin', async(req,res)=>{
  const {email,password} = req.body;
  const userDoc = await User.findOne({email});
  if (userDoc) {
    if (password == userDoc.password) {
      res.json(userDoc)
    } else {
      res.status(422).json('pass not ok');
    }
  } else {
    res.json('not found');
  }
})
module.exports = router