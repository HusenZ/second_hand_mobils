// IMPORT FROM Packages
const express = require('express');
const mongoose = require('mongoose');

//Import form other files
const authRouter = require('./routes/auth');

//INIT
const PORT = 3000;
const app = express(); 
const DB = "mongodb+srv://mohammadhusenzhare:1e2r3t4y5u67@cluster0.eqhecas.mongodb.net/?retryWrites=true&w=majority"
//middleware

app.use(express.json());
app.use(authRouter);

//connections
mongoose.connect(DB).then(()=>{
    console.log('connection successful with MongoDB');
}).catch((e)=>{
    console.log(e);
});

app.listen(PORT,function(){
    console.log(`Connected at port ${PORT}`);  
});
