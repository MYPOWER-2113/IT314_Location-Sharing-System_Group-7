const express = require('express')
const User = require('../models/user.model')
const auth = require("../middleware/auth");
const router = express.Router()
const jwt = require("jsonwebtoken")
const bcryptjs = require("bcryptjs");

// Sign Up
router.post("/signup", async (req, res) => {
  try {
    const { name , email, password, number} = req.body;

    existingUser = (await User.findOne({email})) ;
    if (existingUser) {
      return res
        .status(400)
        .json({ msg: "User with same email already exists!" });
    }
    existingUser = (await User.findOne({number})) ;
    if (existingUser) {
      return res
        .status(400)
        .json({ msg: "User with same number already exists!" });
    }

    const hashedPassword = await bcryptjs.hash(password, 8);

    let user = new User({
      name,
      email,
      password: hashedPassword,
      number,
    });
    user = await user.save();
    res.json(user);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});




router.post("/signin", async (req, res) => {
  try {
    const { email, password} = req.body;

    const user = await User.findOne({email});
    if (!user) {
      return res
        .status(400)
        .json({ msg: "User with this email does not exist!" });
    }

    const isMatch = await bcryptjs.compare(password, user.password);
    if (!isMatch) {
      return res.status(400).json({ msg: "Incorrect password." });
    }

    const token = jwt.sign({ id: user._id }, "passwordKey");
    res.json({ token, ...user._doc });
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});


router.post("/tokenIsValid", async (req, res) => {
  try {
    const token = req.header("x-auth-token");
    if (!token) return res.json(false);
    const verified = jwt.verify(token, "passwordKey");
    if (!verified) return res.json(false);

    const user = await User.findById(verified.id);
    if (!user) return res.json(false);
    res.json(true);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// get user data
router.get("/", auth, async (req, res) => {
  const user = await User.findById(req.user);
  res.json({ ...user._doc, token: req.token });
});

//store SOS number
router.post("/SOSnumber", async (req, res) => {
  try {
    const { email, SOSnumber} = req.body;

    existingUser = (await User.findOne({email})) ;
    if (existingUser) {
      existingUser.SOSnumber = SOSnumber;
      existingUser = await existingUser.save();
      res.json(existingUser);
    }
    else
    {
        return res
        .status(400)
        .json({ msg: "No such user found!" });
    }

  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

module.exports = router
