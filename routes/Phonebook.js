const express = require('express');
const router = express.Router();
const Phonebook = require('../models/Phonebook');

router.get('/', async (req,res) =>{
    const getPhonebook = await Phonebook.find();
    res.json(getPhonebook);
});

//POST
router.post('/', async (req,res) => {
    const newPhonebook = new Phonebook({
        firstname: req.body.firstname,
        lastname: req.body.lastname,
        phoneNumber: req.body.phoneNumber
    });
    const savedPhonebook = await newPhonebook.save();
    res.json(savedPhonebook);
})

module.exports = router;