const router = require('express').Router();

router.host('/register', (req, res) => {
    res.status(200).send("Hello World");
});

module.exports = router;