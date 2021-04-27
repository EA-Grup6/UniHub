"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.deleteUser = exports.loginUser = exports.createUser = exports.helloWorld = void 0;
const User_1 = __importDefault(require("../models/User"));
function helloWorld(req, res) {
    return res.send('Hello World !!!');
}
exports.helloWorld = helloWorld;
async function createUser(req, res) {
    const { username, password } = req.body;
    const user = {
        username: username,
        password: password
    };
    const newUser = new User_1.default(user); // creem l'objecte de MongoDB
    const registeredUser = User_1.default.findOne({ name: username }, function () {
        try {
            if (registeredUser != null) {
                return res.json({
                    code: 201,
                    message: "User already exists"
                });
            }
            else {
                newUser.save();
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
    await registeredUser;
}
exports.createUser = createUser;
async function loginUser(req, res) {
    const { username, password } = req.body;
    const user = {
        username: username,
        password: password
    };
    const registeringUser = new User_1.default(user);
    const registeredUser = User_1.default.findOne({ name: username }, function () {
        try {
            if (registeredUser != null) {
                if (registeredUser.get(password) == registeringUser.password) {
                    return res.json({
                        code: 200,
                        message: "User correctly logged in"
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
    await registeredUser;
}
exports.loginUser = loginUser;
async function deleteUser(req, res) {
    const { username, password } = req.body;
    const registeredUser = User_1.default.findOne({ name: username, password: password }, function () {
        try {
            if (registeredUser != null) {
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
    await registeredUser; // guardem l'usuari amb mongoose
}
exports.deleteUser = deleteUser;
