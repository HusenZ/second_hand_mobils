const express = require('express');
const mongoose = require('mongoose');
const User = require("../models/user");
const  bcryptjs = require('bcryptjs');
const jwt = require('jsonwebtoken');
const verifyToken = require('../middleware/verifyTokenMiddleware');

const authRouter = express.Router();

// Signup route using POST
authRouter.post('/api/signup', async (req, res) => {
    try {
        const { name, email, password } = req.body;
        
        const existingUser = await User.findOne({ email })
        .then(user => {
            if (user) {
              console.log(user);
            } else {
              console.log('User not found.');
            }
          })
          .catch(error => {
            console.error(error);
          });
        if (existingUser) {
            return res.status(409).json({ error: "User with the same email already exists!" });
        }

        const hashedPassword = await bcryptjs.hash(password, 10);

        let user = new User({
            email: email,
            password: hashedPassword,
            name: name,
        });

        user = await user.save();
        res.json(user); // Use 201 for resource creation
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

//Sign in route
authRouter.post('/api/signin', async (req,res)=>{
  try {
    const {email, password} = req.body;

    const user = await User.findOne({email});
    //gard clauses
    if(!user){
      return res.status(400).json({msg:"User with this email does not exist!"});
    }

    const isMatch =  await bcryptjs.compare(password,user.password);

    if(!isMatch){
      return res.status(400).json({msg:"Incorrect password."});
    }

    const token = jwt.sign({id:user._id},"passwordKey");
    res.json({token, ...user._doc});
  } catch (e) {
    res.status(500).json({error:e.message});
  }
})



authRouter.get('/api/user',verifyToken, async(req, res)=>{
  try{
    const userId = req.user.id;

    const user = await User.findById(userId);

    if(!user){
      return res.status(404).json({message:'user not found'});
    }

    res.json({
      _id:user.id,
      name:user.name,
      email:user.email,
    })
  } catch(error){
    console.error(error);
    res.status(500).json({message:'Server error'});
  }
})

module.exports = authRouter;
