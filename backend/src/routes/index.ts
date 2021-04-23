import {Router} from 'express';
import {helloWorld, createUser, loginUser, deleteUser} from '../controllers/hospital.controller'

const router = Router();
    
router.route('/').get(helloWorld); //la part lògica esta en un altre document en el controlador de cada cosa

router.route('/User/newHospital/').post(createUser);
    
router.route('/User/listHospital/').post(loginUser);

router.route('/User/deleteHospital/').post(deleteUser);

export default router;