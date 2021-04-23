"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const hospital_controller_1 = require("../controllers/hospital.controller");
const router = express_1.Router();
router.route('/').get(hospital_controller_1.helloWorld); //la part lògica esta en un altre document en el controlador de cada cosa
router.route('/User/newHospital/').post(hospital_controller_1.createUser);
router.route('/User/listHospital/').post(hospital_controller_1.loginUser);
router.route('/User/deleteHospital/').post(hospital_controller_1.deleteUser);
exports.default = router;
