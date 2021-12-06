const express = require('express');
const mongoose = require('mongoose');
const { thingspeakPost } = require('../../public/thinkspeak');

const router = express.Router();
const Medicine = require('../models/medicine');

router.get('/', (req, res) => {
    const result = Medicine.find().exec().then(doc => {
        if (doc == null || doc.length == 0) {
            res.status(404).json({
                message: "Resource Not located or is empty"
            });

        } else {
            res.status(200).json({
                message: "Resource Identified",
                doc: doc
            });
        }

    }).catch(err => {
        console.log(`\n....Error in the main Route GET request: \n` + err);
        res.status(500).json({
            message: "Error in the main Route GET request",
            error: err
        });
    });
});

router.get('/:medicineId', (req, res) => {
    const medicineId = req.params.medicineId;
    const result = Medicine.findById({ _id: medicineId })
        .exec()
        .then(doc => {
            if (doc == null || doc.length == 0) {
                res.status(404).json({
                    message: "Resource Not located or is empty"
                });

            } else {
                res.status(200).json({
                    message: "Resource Identified",
                    doc: doc
                });
            }
        })
        .catch(err => {
            console.log(`\n....Error in the medicine Route GET request: \n` + err);
            res.status(500).json({
                message: "Error in the medicine Route GET request",
                error: err
            });
        });
});

router.post('/', (req, res) => {
    console.log(req.body);
    const medicine = {
        _id: mongoose.Types.ObjectId(),
        name: req.body.name,
        type: req.body.type,
        description: req.body.description,
        ringTime: req.body.ringTime
    };
    console.log(`request for POST ${medicine}`);
    thingspeakPost(`zz${req.body.ringTime}zz`, 1, "Screen").then(status => {
        if (status != 200) {
            res.status(status).json({
                message: "Some Error occured in POST thingspeak"
            });
        }

        Medicine.create(medicine).then(args => {
            res.status(200).json({
                message: "Document created",
                doc: args
            });

        }).catch(err => {
            console.log("\n...Error in creating new document:\n" + err);
            res.status(500).json({
                message: "Error in creating POST Request",
                error: err
            });
        });
    }).catch(err => {
        res.status(500).json({});
    });
});

router.post('/ring/:type', (req, res) => {
    const medType = req.params.type;
    thingspeakPost(medType, 1, 'Ring').then(status => {
        res.status(status).json({ message: "Done" });
    }).catch(err => {
        res.status(500).json({ message: "Some error occured" });
    });
});

router.patch('/:medicineId', (req, res) => {
    const medicineId = req.params.medicineId;
    Medicine.updateOne({ _id: medicineId }, {
        $set: {
            name: req.body.name,
            type: req.body.type,
            description: req.body.description,
            ringTime: req.body.ringTime
        }
    }).exec().then(result => {
        console.log(result);
        res.status(200).json({
            message: "Document update successfully",
        });

    }).catch(err => {
        console.log("\n...Error in updating:\n" + err);
        res.status(500).json({
            error: err,
        });
    });
});

router.delete('/:medicineId', (req, res) => {
    const medicineId = req.params.medicineId;
    Medicine.deleteOne({ _id: medicineId }).exec()
        .then((result) => {
            if (result.length == 0) {
                res.status(404).json({
                    message: "Resource not located"
                });
            } else {
                res.status(200).json({
                    message: "Item deletion successful"
                });
            }
        })
        .catch(err => {
            console.log("\n..Error in DELETE request:\n" + err);
            res.status(500).json({
                message: "Error in DELETE request",
                error: err
            });
        });
});

module.exports = router;