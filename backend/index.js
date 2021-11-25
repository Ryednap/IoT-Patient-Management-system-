const express = require('express');
const app = express();

const authRoute = require('./routes/auth');

// Route middleware

app.listen(3000, () => console.log("Server is running"));