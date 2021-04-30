"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const user_controller_1 = require("../controllers/user.controller");
const router = express_1.Router();
router.route('/').get(user_controller_1.helloWorld); //la part lògica esta en un altre document en el controlador de cada cosa
router.route('/User/newUser/').post(user_controller_1.createUser);
router.route('/User/loginUser/').post(user_controller_1.loginUser);
router.route('/User/deleteUser/').post(user_controller_1.deleteUser);
//router.route('/User/loginUser/').put(loginUser); //Forgot password
exports.default = router;
