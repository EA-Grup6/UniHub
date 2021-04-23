"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const user_controller_1 = require("../controllers/hospital.controller");
const router = express_1.Router();
router.route('/')
    .get(hospital_controller_1.helloWorld); //la part lògica esta en un altre document en el controlador de cada cosa
router.route('/newHospital') //newUser-->newHospital
    .post(hospital_controller_1.createUser);
router.route('/listHospital')//login-->list
    .get(hospital_controller_1.loginUser);
router.route('/deleteHospital') //deleteHospital
    .delete(user_controller_1.deleteUser);
exports.default = router;
