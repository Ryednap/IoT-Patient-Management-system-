// environment configuration
require('dotenv').config();

const http = require('http');
const app = require('./api/routes/app');

const httpServer = http.createServer(app);
const port = process.env.PORT || 3000;

httpServer.listen(port, () => {
    console.log(`Server is listening at port: ${port}`);
});