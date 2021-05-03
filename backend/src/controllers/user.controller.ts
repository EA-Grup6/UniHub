import {Request, Response} from 'express'
import User from '../models/User'

export function helloWorld(req: Request, res: Response){
    return res.send('Hello World !!!')
}
export async function createUser (req: Request, res: Response){

    let {username, password, tag} = req.body;
    const user = {username: username,password: password,tag: tag};
    let newUser = new User(user);
    var registeredUser = await User.findOne({username:newUser.username})
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

    let {username, password, tag} = req.body;
    const user = {username: username,password: password,tag: tag};
    console.log("Username: " + user.username);
    console.log("Password: " + user.password);
    const registeringUser = new User(user);
    var registeredUser = await User.findOne({username:registeringUser.username})
    try{
        if(registeredUser != null){
            if(registeredUser.get('password') == registeringUser.password){
                return res.status(200).send('200');
            } else {
                return res.status(201).send('201');
            }
        } else {
            return res.status(404).send('404');
        }
    } catch {
        return res.status(500).send('500');
    }
}

export async function deleteUser (req: Request, res: Response){

    const{username} = req.body;
    const registeredUser = await User.findOne({name:username});
    try{
        if(registeredUser != null){
            User.findOneAndDelete({username: registeredUser.username});
            return res.status(200).send({message: "User correctly gotten"});
        } else {
            return res.status(404).send({message: "Users not found"});
        }
    } catch {
        return res.status(500).send({message: "Internal server error"});
    }


}

export async function getUsers (req: Request, res: Response){

    const users = await User.find();

    try{
        if(users != null){
           
            res.status(200).json(users);
        } else {
            return res.status(404).send({message: "Users not found"});
        }
    } catch {
        return res.status(500).send({message: "Internal server error"});
    }

}


export async function getAdmin(req: Request, res: Response) {

    let { username, password, tag } = req.body;
    const admin = { username: username,password: password,tag: tag };
    const adminUser = new User(admin);
    const adminstUser = await User.findOne({ username:adminUser.username });
    
    try {
        if (adminstUser != null){
            if (adminstUser.get('tag') != null) {

                res.status(200);
            } else {
                return res.status(404).send({ message: "User admin not found" });
        }
        }
    } catch {
        return res.status(500).send({ message: "Internal server error" });
    }

}

