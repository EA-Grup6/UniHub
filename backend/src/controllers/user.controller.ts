import {Request, Response} from 'express'
import User from '../models/User'
import jwt from 'jsonwebtoken'

export function helloWorld(req: Request, res: Response){
    return res.send('Hello World !!!')
}
export async function createUser (req: any, res: Response){
    const Btoken = req.headers['authorization'];

    let {username, password, isAdmin} = req.body;
    let newUser = new User();
    newUser.username = username;
    newUser.password = password;
    newUser.fullname = '';
    newUser.description = '';
    newUser.university = '';
    newUser.degree = '';
    newUser.role = '';
    newUser.subjectsDone = '';
    newUser.subjectsRequested = '';
    newUser.recommendations = '';
    newUser.isAdmin = false;
    newUser.phone= '';
    var registeredUser = await User.findOne({username:newUser.username})
    if(typeof Btoken !== undefined){
        req.token = Btoken;
        jwt.verify(req.token, 'mykey', async(error: any, authData: any) => {
            if(error){
                return res.status(205).send({message: 'Authorization error'});
            } else {
                try{
                    if(registeredUser != null){
                        return res.status(201).send({message: "User already exists"});
                    } else {
                        let result = await newUser.save();
                        return res.status(200).send(result);
                    }
                } catch {
                    return res.status(500).send({message: "Internal server error"});
                }
            }
        });
    } else {
        return res.status(204).send({message: 'Unauthorized'});
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
                let registeredUserId = registeredUser._id;
                var token = await jwt.sign({id: registeredUserId}, 'mykey', {expiresIn: 86400});
                if(registeredUser.get('isAdmin')){
                    return res.status(202).send(token);
                }else
                    return res.status(200).send(token);
            } else {
                return res.status(201).send('Wrong password');
            }
        } else {
            return res.status(404).send('User not found');
        }
    } catch {
        return res.status(500).send('Internal server error');
    }
}

export async function deleteUser (req: any, res: Response){

    const Btoken = req.headers['authorization'];

    if(typeof Btoken !== undefined){
        req.token = Btoken;
        jwt.verify(req.token, 'mykey', async(error: any, authData: any) => {
            if(error){
                return res.status(205).send({message: 'Authorization error'});
            } else {
                try{
                    await User.findOneAndRemove({username: req.params.username});
                    return res.status(200).send({message: "User correctly deleted"});
                } catch {
                    return res.status(500).send({message: "Internal server error"});
                }
            }
        });
    } else {
        return res.status(204).send({message: 'Unauthorized'});
    }
}

export async function updateUser (req: any, res: Response){
    let{username, password, fullname, description, university, degree, role, subjectsDone, subjectsRequested, phone} = req.body;
    const Btoken = req.headers['authorization'];
    const updateData = {
        password: password,
        fullname: fullname,
        description: description,
        university: university,
        degree: degree,
        role: role,
        subjectsDone: subjectsDone,
        subjectsRequested: subjectsRequested,
        phone: phone};
    console.log(updateData);

    if(typeof Btoken !== undefined){
        req.token = Btoken;
        jwt.verify(req.token, 'mykey', async(error: any, authData: any) => {
            if(error){
                return res.status(205).send({message: 'Authorization error'});
            } else {
                try {
                    await User.findOneAndUpdate({username: username}, updateData);
                    return res.status(200).send({message: 'User correctly updated'});
                } catch {
                    return res.status(201).send({message: "User couldn't be updated"});
                }
            }
        });
    } else {
        return res.status(204).send({message: 'Unauthorized'});
    }

}

export async function getUsers (req: any, res: Response){

    const Btoken = req.headers['authorization'];

    const users = await User.find();
    console.log(users);

    if(typeof Btoken !== undefined){
        req.token = Btoken;
        jwt.verify(req.token, 'mykey', async(error: any, authData: any) => {
            if(error){
                return res.status(205).send({message: 'Authorization error'});
            } else {
                try{
                    if(users != null){
                        return res.status(200).header('Content Type - application/json').send(users);
            
                    } else {
                        return res.status(404).send({message: "Users not found"});
                    }
                } catch {
                    return res.status(500).send({message: "Internal server error"});
                }
            }
        });
    } else {
        return res.status(204).send({message: 'Unauthorized'});
    }

}


export async function getAdmin(req: any, res: Response) {

    const Btoken = req.headers['authorization'];
    if(typeof Btoken !== undefined){
        req.token = Btoken;
        jwt.verify(req.token, 'mykey', async(error: any, authData: any) => {
            if(error){
                return res.status(205).send({message: 'Authorization error'});
            } else {
                try{
                    let user = await User.findById(req.params.id);
                    if(user!=null){
                        if (user.isAdmin== true){
                            return res.status(200).send({message: "User is Admin"});
                        }else{
                            return res.status(201).send({message: "User is not Admin"});
                        }
                    }else{
                        return res.status(202).send({message: "User not found"});    
                    }
            
                }catch {      
              
                    return res.status(500).send({message: "Internal server error"});
                }
            }
        });
    } else {
        return res.status(204).send({message: 'Unauthorized'});
    }

}

export async function getUser(req: any, res: Response) {
    let username = req.params.username;
    let user = await User.findOne({username: username});
    const Btoken = req.headers['authorization'];
    if(typeof Btoken !== undefined){
        req.token = Btoken;
        jwt.verify(req.token, 'mykey', async(error: any, authData: any) => {
            if(error){
                return res.status(205).send({message: 'Authorization error'});
            } else {
                try{
                    if(user!=null){
                        return res.status(200).header('Content Type - application/json').send(user);
                    } else {
                        return res.status(201).send({message: "User not found"});
                    }
                } catch {
                    return res.status(500).send({message: "Internal server error"});
                }
            }
        });
    } else {
        return res.status(204).send({message: 'Unauthorized'});
    }
}
