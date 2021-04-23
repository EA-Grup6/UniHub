"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.deleteHospital = exports.loginHospital = exports.createUser = exports.helloWorld = void 0;
const Hospital_1 = __importDefault(require("../models/Hospital"));
function helloWorld(req, res) {
    return res.send('Hello World !!!');
}
exports.helloWorld = helloWorld;
async function createUser(req, res) {
    let { username, description, url } = req.body;
    let hospital = { username: username, description: description, url: url };
    let newHospital = new Hospital_1.default(hospital);
    let registeredHospital = await Hospital_1.default.findOne({ username: newHospital.username });
    try {
        if (registeredHospital != null) {
            return res.status(201).send({ message: "User already exists" });
        }
        else {
            let result = newHospital.save();
            return res.status(200).send(result);
        }
    }
    catch {
        return res.status(500).send({ message: "Internal server error" });
    }
}
exports.createUser = createUser;
async function loginHospital(req, res) {
    let { username, description, url } = req.body;
    const hospital = {
        username: username,
        description: description,
        url: url
    };
    console.log("Username: " + hospital.username);
    console.log("Description: " + hospital.description);
    console.log("Url: " + hospital.url);
    const registeringHospital = new Hospital_1.default(hospital);
    var registeredHospital = await Hospital_1.default.findOne({ username: registeringHospital.username });
    try {
        if (registeredHospital != null) {
            if (registeredHospital.get('Description') == registeringHospital.description) {
                return res.status(200).send('200');
            }
            else {
                return res.status(201).send('201');
            }
        }
        else {
            return res.status(404).send('404');
        }
    }
    catch {
        return res.status(500).send('500');
    }
}
exports.loginHospital = loginHospital;
async function deleteHospital(req, res) {
    const { username } = req.body;
    const registeredHospital = await Hospital_1.default.findOne({ name: username });
    try {
        if (registeredHospital != null) {
            Hospital_1.default.findOneAndDelete({ username: registeredHospital.username });
            return res.status(200).send({ message: "Hospital correctly deleted" });
        }
        else {
            return res.status(404).send({ message: "Hospital not found" });
        }
    }
    catch {
        return res.status(500).send({ message: "Internal server error" });
    }
}
exports.deleteHospital = deleteHospital;
