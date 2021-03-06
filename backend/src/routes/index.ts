import {Router} from 'express';
import {helloWorld, createUser, loginUser, deleteUser} from '../controllers/user.controller'

const router = Router();
    
router.route('/').get(helloWorld); //la part lògica esta en un altre document en el controlador de cada cosa

router.route('/User/newUser/').post(createUser);
    
router.route('/User/loginUser/').post(loginUser);

router.route('/User/deleteUser/').post(deleteUser);

//router.route('/User/loginUser/').put(loginUser); //Forgot password

export default router;