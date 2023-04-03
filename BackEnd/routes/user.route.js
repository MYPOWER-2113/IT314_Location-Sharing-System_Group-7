const express = require('express')
const User = require('../models/user.model')
const router = express.Router()

//hello
router.post('/signup',async(req,res)=>{
    const {email,password} = req.body;

  try {
    const userDoc = await User.create({
      email,
      password,
    });
    res.json(userDoc);
  } catch (e) {
    res.status(422).json(e);
  }
    
})

router.post('/signin', async(req,res)=>{
  const {email,password} = req.body;
  const userDoc = await User.findOne({email});
  if (userDoc) {
    const passOk = compareSync(password, userDoc.password);
    if (passOk) {
      jwt.sign({
        email:userDoc.email,
        id:userDoc._id
      }, jwtSecret, {}, (err,token) => {
        if (err) throw err;
        res.cookie('token', token).json(userDoc);
      });
    } else {
      res.status(422).json('pass not ok');
    }
  } else {
    res.json('not found');
  }
})
module.exports = router