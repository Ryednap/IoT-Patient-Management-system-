const mongoose = require('mongoose');

const medicineSchema = mongoose.Schema({
    _id: mongoose.Schema.Types.ObjectId,
    name: mongoose.Schema.Types.String,
    type: mongoose.Schema.Types.String,
    description: mongoose.Schema.Types.String,
    ringTime: mongoose.Schema.Types.String,
});

module.exports = mongoose.model('medicineModel', medicineSchema);
