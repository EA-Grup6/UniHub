import {Router} from 'express';
import {helloWorld, createUser, loginUser, deleteUser} from '../controllers/user.controller'

const router = Router();
    
router.route('/').get(helloWorld) //la part lògica esta en un altre document en el controlador de cada cosa

router.route('/newUser').post(createUser)
    
router.route('/login').get(loginUser)

router.route('/deleteUser').delete(deleteUser)

export default router;