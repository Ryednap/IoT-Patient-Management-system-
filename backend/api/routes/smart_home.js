const express = require('express');
const { thingspeakGet, thingspeakPost } = require('../../public/thinkspeak');

const router = express.Router();

router.get('/temperature', (req, res) => {
    thingspeakGet(1, 1).then(data => {
        const feeds = data[0].feeds[0];
        res.status(200).json(feeds);
    }).catch(err => {
        console.log(err);
        res.status(500).json({
            message: "Error occured in GET request",
            error: err
        })
    });
});

router.post('/smartAc', (req, res) => {
    thingspeakPost(req.body.state, 2).then(status => {
        res.status(status).json({
            message: "Success in sending"
        })
    }).catch(err => {
        console.log(err);
        res.status(500).json({
            error: err
        });
    });
});

router.post('/smartLight', (req, res) => {
    thingspeakPost(req.body.state, 3).then(status => {
        res.status(status).json({
            message: "Success in sending"
        })
    }).catch(err => {
        console.log(err);
        res.status(500).json({
            error: err
        });
    });;
});

router.post('/smartTV', (req, res) => {
    thingspeakPost(req.body.state, 4).then(status => {
        res.status(status).json({
            message: "Success in sending"
        })
    }).catch(err => {
        console.log(err);
        res.status(500).json({
            error: err
        });
    });;
});


module.exports = router;