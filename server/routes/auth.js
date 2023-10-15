const express = require('express');
const mongoose = require('mongoose');
const User = require("../models/user");

const authRouter = express.Router();

// Signup route using POST
authRouter.post('/api/signup', async (req, res) => {
    try {
        const { name, email, password } = req.body;

        const existUser = await User.findOne({ email });
        if (existUser) {
            return res.status(409).json({ error: "User with the same email already exists!" });
        }

        const user = new User({
            email,
            password,
            name,
        });

        await user.save();
        res.status(200).json(user); // Use 201 for resource creation
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

module.exports = authRouter;
