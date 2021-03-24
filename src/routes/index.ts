import {Router} from 'express';
import {helloWorld, createUser} from '../controllers/user.controller'


import multer from '../libs/multer'

const router = Router();
    
router.route('/')
    .get(helloWorld)// la part lògica esta en un altre document en el controlador de cada cosa


router.route('/users')
    .post(createUser)
    //Crear el usercontroller
    //Crear el model User
    //Crear les rutes 
    // Us INSOMNIA
    

export default router;