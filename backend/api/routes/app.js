const express = require('express');
const morgan = require('morgan');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');

const app = express();


app.use(morgan('dev'));
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

app.use((req, res, next) => {
    res.header('Acess-Control-Allow-Origin', "*");
    res.header('Acess-Control-Allow-Headers', "*");
    if (req.method == 'OPTIONS') {
        res.header('Acess-Control-Allow-Methods', 'GET, POST, DELETE, PATCH, PUT');
        return res.status(200).json();
    }
    next();
});




app.use((req, res, next) => {
    let error = new Error("requset reached the last endpoint: No Location found");
    error.status = 404;
    next(error);
});

app.use((error, req, res, next) => {
    res.status(erorr.status || 5000).json({
        error: {
            message: error.message
        }
    });
})

module.exports = app;