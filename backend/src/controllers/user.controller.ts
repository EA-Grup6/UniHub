import {Request, Response} from 'express'
import User from '../models/User'

export function helloWorld(req: Request, res: Response): Response {
    return res.send('Hello World !!!')
}

export async function createUser (req: Request, res: Response): Promise<void> {

    const{username, password} = req.body;

    const user ={
        username: username,
        password: password
    };

    const newUser = new User (user); // creem l'objecte de MongoDB
    const registeredUser = User.findOne({name:username}, function(){
        try{
            if(registeredUser != null){
                return res.json({
                    code: 201,
                    message: "User already exists"
                });
            }
            else{
                newUser.save();
                return res.json({
                    code: 200,
                    message: "User correctly registered"
                });
            }
        }
        catch{
            return res.json({
                code: 500,
                message: "Internal server error"
            });
        }
    })
    await registeredUser;
}

export async function loginUser (req: Request, res: Response): Promise<void> {

    const{ username, password} = req.body;

    const user = {
        username: username,
        password: password
    };

    const registeringUser = new User(user);

    const registeredUser = User.findOne({name:username}, function(){
        try{
            if(registeredUser != null){
                if(registeredUser.get(password) == registeringUser.password){
                    return res.json({
                        code: 200,
                        message: "User correctly logged in"
                    });
                }
                else{
                    return res.json({
                        code: 201,
                        message: "Wrong password"
                    });
                }
            }
            else{
                return res.json({
                    code: 404,
                    message: "User not found"
                });
            }
        }
        catch{
            return res.json({
                code: 500,
                message: "Internal server error"
            });
        }
    })
    await registeredUser;
}

export async function deleteUser (req: Request, res: Response): Promise<void> {

    const{ username, password} = req.body;

    const registeredUser = User.findOne({name:username, password:password}, function(){
        try{
            if(registeredUser != null){
                if(registeredUser.get(password) == password){
                    return res.json({
                        code: 200,
                        message: "User correctly deleted"
                    });
                }
                else{
                    User.findOneAndDelete(registeredUser);
                    return res.json({
                        code: 201,
                        message: "Wrong password"
                    });
                }
            }
            else{
                return res.json({
                    code: 404,
                    message: "User not found"
                });
            }
        }
        catch{
            return res.json({
                code: 500,
                message: "Internal server error"
            });
        }
    })
    await registeredUser;               // guardem l'usuari amb mongoose
}