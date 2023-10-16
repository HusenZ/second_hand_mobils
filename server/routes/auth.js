const express = require('express');
const mongoose = require('mongoose');
const User = require("../models/user");
const  bcryptjs = require('bcryptjs');

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

module.exports = authRouter;
