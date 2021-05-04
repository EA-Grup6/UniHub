"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.getUser = exports.getAdmin = exports.getUsers = exports.updateUser = exports.deleteUser = exports.loginUser = exports.createUser = exports.helloWorld = void 0;
const User_1 = __importDefault(require("../models/User"));
function helloWorld(req, res) {
    return res.send('Hello World !!!');
}
exports.helloWorld = helloWorld;
async function createUser(req, res) {
    let { username, password, tag } = req.body;
    let newUser = new User_1.default();
    newUser.username = username;
    newUser.password = password;
    newUser.fullname = '';
    newUser.description = '';
    newUser.university = '';
    newUser.degree = '';
    newUser.role = '';
    newUser.subjectsDone = '';
    newUser.subjectsRequested = '';
    newUser.recommendations = '';
    newUser.isAdmin = false;
    newUser.phone = '';
    var registeredUser = await User_1.default.findOne({ username: newUser.username });
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
    let { username, password, tag } = req.body;
    const user = { username: username, password: password, tag: tag };
    console.log("Username: " + user.username);
    console.log("Password: " + user.password);
    const registeringUser = new User_1.default(user);
    var registeredUser = await User_1.default.findOne({ username: registeringUser.username });
    try {
        if (registeredUser != null) {
            if (registeredUser.get('password') == registeringUser.password) {
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
exports.loginUser = loginUser;
async function deleteUser(req, res) {
    const username = req.params;
    const registeredUser = await User_1.default.findOne({ username: username });
    try {
        if (registeredUser != null) {
            User_1.default.findOneAndDelete({ username: registeredUser.username });
            return res.status(200).send({ message: "User correctly gotten" });
        }
        else {
            return res.status(404).send({ message: "Users not found" });
        }
    }
    catch {
        return res.status(500).send({ message: "Internal server error" });
    }
}
exports.deleteUser = deleteUser;
async function updateUser(req, res) {
    let { username, password, fullname, description, university, degree, role, subjectsDone, subjectsAsking } = req.body;
    const updateData = {
        password: password,
        fullname: fullname,
        description: description,
        university: university,
        degree: degree,
        role: role,
        subjectsDone: subjectsDone,
        subjectsRequested: subjectsAsking,
        phone: ''
    };
    console.log(updateData);
    try {
        var status = await User_1.default.findOneAndUpdate({ username: username }, { update: updateData });
        console.log(status);
        return res.status(200).send({ message: 'User correctly updated' });
    }
    catch {
        return res.status(201).send({ message: "User couldn't be updated" });
    }
}
exports.updateUser = updateUser;
async function getUsers(req, res) {
    const users = await User_1.default.find();
    console.log(users);
    try {
        if (users != null) {
            return res.status(200).header('Content Type - application/json').send(users);
        }
        else {
            return res.status(404).send({ message: "Users not found" });
        }
    }
    catch {
        return res.status(500).send({ message: "Internal server error" });
    }
}
exports.getUsers = getUsers;
async function getAdmin(req, res) {
    let { username, password, tag } = req.body;
    const admin = { username: username, password: password, tag: tag };
    const adminUser = new User_1.default(admin);
    const adminstUser = await User_1.default.findOne({ username: adminUser.username });
    try {
        if (adminstUser != null) {
            if (adminstUser.get('tag') != null) {
                res.status(200);
            }
            else {
                return res.status(404).send({ message: "User admin not found" });
            }
        }
    }
    catch {
        return res.status(500).send({ message: "Internal server error" });
    }
}
exports.getAdmin = getAdmin;
async function getUser(req, res) {
    let username = req.params.username;
    let user = await User_1.default.findOne({ username: username });
    try {
        if (user != null) {
            return res.status(200).header('Content Type - application/json').send(user);
        }
        else {
            return res.status(201).send({ message: "User not found" });
        }
    }
    catch {
        return res.status(500).send({ message: "Internal server error" });
    }
}
exports.getUser = getUser;
