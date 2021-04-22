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
    let { username, password } = req.body;
    let user = { username: username, password: password };
    let newUser = new User_1.default(user);
    let registeredUser = await User_1.default.findOne({ name: username });
    try {
        if (registeredUser != null) {
            return res.status(201).send({ message: "User already exists" });
        }
        else {
            let result = newUser.save();
            return res.status(200).send(result);
        }
    }
    catch {
        return res.status(500).send({ message: "Internal server error" });
    }
}
exports.createUser = createUser;
async function loginUser(req, res) {
    const { username, password } = req.body;
    const user = {
        username: username,
        password: password
    };
    const registeringUser = new User_1.default(user);
    const registeredUser = await User_1.default.findOne({ name: username });
    try {
        if (registeredUser != null) {
            if (registeredUser.get(password) == registeringUser.password) {
                return res.status(200).send({ message: "User correctly logged in" });
            }
            else {
                return res.status(201).send({ message: "Wrong password" });
            }
        }
        else {
            return res.status(404).send({ message: "User not found" });
        }
    }
    catch {
        return res.status(500).send({ message: "Internal server error" });
    }
}
exports.loginUser = loginUser;
async function deleteUser(req, res) {
    const { username } = req.body;
    const registeredUser = await User_1.default.findOne({ name: username });
    try {
        if (registeredUser != null) {
            User_1.default.findOneAndDelete({ username: registeredUser.username });
            return res.status(200).send({ message: "User correctly deleted" });
        }
        else {
            return res.status(404).send({ message: "User not found" });
        }
    }
    catch {
        return res.status(500).send({ message: "Internal server error" });
    }
}
exports.deleteUser = deleteUser;
