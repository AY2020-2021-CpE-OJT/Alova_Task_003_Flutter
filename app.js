const express = require('express');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');
require('dotenv/config');

const app = express();

app.use(bodyParser.json());

mongoose.connect(
    process.env.DB_CONNECTION,
    {useNewUrlParser: true, useUnifiedTopology: true},
    console.log('DB is connected')
);

app.get('/', (req,res) =>{
    res.send('Hello World!');
});

//route for phonebook
const  phoneBookRoute = require('./routes/Phonebook');
app.use('/phoneBook', phoneBookRoute);

app.listen(3000);