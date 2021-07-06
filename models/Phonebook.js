const mongoose = require('mongoose');

const phoneBookSchema = mongoose.Schema({
    firstname: String,
    lastname: String,
    phoneNumber: String
});
module.exports = mongoose.model('phone_books', phoneBookSchema);