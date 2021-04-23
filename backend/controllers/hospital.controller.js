"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.deleteHospital = exports.listHospital = exports.createHospital = exports.helloWorld = void 0;
const Hospital_1 = __importDefault(require("../models/Hospital"));
function helloWorld(req, res) {
    return res.send('Hello World !!!');
}
exports.helloWorld = helloWorld;
async function createHospital(req, res) {
    const { username, description, url } = req.body;
    const hospital = {
        username: username,
        description: description,
        url: url
    };
    const newHospital = new Hospital_1.default(hospital); // creem l'objecte de MongoDB
    const registeredHospital = Hospital_1.default.findOne({ name: username }, function () {
        try {
            if (registeredHospital != null) {
                return res.json({
                    code: 201,
                    message: "User already exists"
                });
            }
            else {
                newHospital.save();
                return res.json({
                    code: 200,
                    message: "User correctly registered"
                });
            }
        }
        catch {
            return res.json({
                code: 500,
                message: "Internal server error"
            });
        }
    });
    await registeredHospital;
}
exports.createHospital = createHospital;
async function llustnUser(req, res) {
    const { username, password,url } = req.body;
    const user = {
        username: username,
        description: description,
        url: url
    };
    const registeringHospital = new Hospital_1.default(user);
    const registeredHospital = Hospital_1.default.findOne({ name: username }, function () {
        try {
            if (registeredHospital != null) {
                if (registeredHospital.get(username) == registeringUser.username) {
                    return res.json({
                        code: 200,
                        message: "Already exists "
                    });
                }
                else {
                    return res.json({
                        code: 201,
                        message: "Wrong password"
                    });
                }
            }
            else {
                return res.json({
                    code: 404,
                    message: "User not found"
                });
            }
        }
        catch {
            return res.json({
                code: 500,
                message: "Internal server error"
            });
        }
    });
    await registeredHospital;
}
exports.listHospital = listHospital;
async function deleteHospital(req, res) {
    const { username, description ,url } = req.body;
    const registeredUser = User_1.default.findOne({ name: username,description: description, url:url }, function () {
        try {
            if (registeredHospital != null) {
                if (registeredUser.get(password) == password) {
                    return res.json({
                        code: 200,
                        message: "User correctly deleted"
                    });
                }
                else {
                    User_1.default.findOneAndDelete(registeredUser);
                    return res.json({
                        code: 201,
                        message: "Wrong password"
                    });
                }
            }
            else {
                return res.json({
                    code: 404,
                    message: "User not found"
                });
            }
        }
        catch {
            return res.json({
                code: 500,
                message: "Internal server error"
            });
        }
    });
    await registeredHospital; // guardem l'usuari amb mongoose
}
exports.deleteUser = deleteHospital;
