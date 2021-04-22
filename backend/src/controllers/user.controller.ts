import {Request, Response} from 'express'
import User from '../models/User'

export function helloWorld(req: Request, res: Response){
    return res.send('Hello World !!!')
}
export async function createUser (req: Request, res: Response){

    let {username, password} = req.body;
    let user = {username: username,password: password};
    let newUser = new User(user);
    let registeredUser = await User.findOne({username:newUser.username})
    try{
        if(registeredUser != null){
            return res.status(201).send({message: "User already exists"});
        } else {
            let result = newUser.save();
            return res.status(200).send(result);
        }
    } catch {
        return res.status(500).send({message: "Internal server error"});
    }
}

export async function loginUser (req: Request, res: Response){

    let {username, password} = req.body;
    const user = {
        username: username,
        password: password
    };
    console.log("Username: " + user.username);
    console.log("Password: " + user.password);
    const registeringUser = new User(user);
    const registeredUser = await User.findOne({username:registeringUser.username})
    try{
        if(registeredUser != null){
            if(registeredUser.get('password') == registeringUser.password){
                return res.status(200).send({message: "User correctly logged in"});
            } else {
                return res.status(201).send({message: "Wrong password"});
            }
        } else {
            return res.status(404).send({message: "User not found"});
        }
    } catch {
        return res.status(500).send({message: "Internal server error"});
    }
}

export async function deleteUser (req: Request, res: Response){

    const{username} = req.body;

    const registeredUser = await User.findOne({name:username});
    try{
        if(registeredUser != null){
            User.findOneAndDelete({username: registeredUser.username});
            return res.status(200).send({message: "User correctly deleted"});
        } else {
            return res.status(404).send({message: "User not found"});
        }
    } catch {
        return res.status(500).send({message: "Internal server error"});
    }
}