const urllib = require('urllib');
const Promise = require('bluebird');

const urllibRequestAsync = Promise.promisify(urllib.request);
/**
 * @function
 * @param {*} data 
 * @param {*} field 
 * create a POST request to the Thingspeak API to the desired 'Field' 
 * with the given 'data'
 */

let thingspeakPost = function (data, field) {
    const URL = process.env.THINGSPEAK_WRITE_URL;
    const KEY = process.env.THINGSPEAK_WRITE_KEY;
    const HEADER = `&field${field}='${data}'`;

    const NEW_URL = URL + KEY + HEADER;
    console.log("Sending POST request to " + NEW_URL);
    return Promise.all([urllibRequestAsync(NEW_URL).then((data) => {
        return 200;
    }).catch((err) => {
        return 500;
    })]);
    /*     urllib.request(NEW_URL, (err, doc, res) => {
            if (err) {
                console.log("Error occured in thingspeakPost\n " + err);
            }
            console.log(`Response status ${res.statusCode}`);
        }); */
};

/**
 * @function
 * @param {*} field 
 * 
 * provides GET request to the THINGSPEAK API to the 
 * given 'field' returns null if error or else 
 * JSON document
 */

let thingspeakGet = async function (field, temp) {
    let URL = process.env.THINGSPEAK_READ_URL;
    let KEY = process.env.THINGSPEAK_READ_KEY;
    if (temp != null) {
        KEY = process.env.THINGSPEAK_TEMPERATURE_READ_KEY;
        URL = process.env.THINGSPEAK_TEMPERATURE_READ_URL;
    }
    const HEADER = "&results=1";
    const NEW_URL = URL + `${field}.json?api_key=` + KEY + HEADER;
    console.log("sending GET request to " + NEW_URL);

    return Promise.all([urllibRequestAsync(NEW_URL).then((data) => {
        return JSON.parse(data.toString());
    }).catch((err) => {
        throw err;
    })]);

    /*     urllib.request(NEW_URL, (err, doc, res) => {
            if (err) {
                console.log("Error occured in thingspeakGet: \n " + err);
                return null;
            }
            console.log(`Response GET status: ${res.statusCode}`);
            const data = JSON.parse(doc.toString());
            console.log(data);
            return data;
        }); */

};

module.exports = { thingspeakGet, thingspeakPost };