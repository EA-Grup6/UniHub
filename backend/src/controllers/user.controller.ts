import {Request, Response} from 'express'
import User from '../models/User'
import jwt from 'jsonwebtoken'
import University from '../models/University'
import Faculty from '../models/Faculty';
import Degree from '../models/Degree';
import feedPublication from '../models/feedPublication';
import offer from '../models/offer';
import { deleteFeed} from './feedPublication.controller';
let mongoose = require('mongoose');


export async function createUser (req: any, res: Response){
    let {username, password} = req.body;
    let newUser = new User();
    newUser._id = new mongoose.Types.ObjectId();
    newUser.username = username;
    newUser.password = password;
    newUser.fullname = '';
    newUser.description = '';
    newUser.university = '';
    newUser.degree = '';
    newUser.role = '';
    newUser.subjectsDone = [];
    newUser.subjectsRequested = [];
    newUser.recommendations = '';
    newUser.isAdmin = false;
    newUser.phone= '';
    newUser.following = [];
    newUser.followers = [];
    newUser.profilePhoto = 'https://d500.epimg.net/cincodias/imagenes/2016/07/04/lifestyle/1467646262_522853_1467646344_noticia_normal.jpg';
    var registeredUser = await User.findOne({username:newUser.username});
    try{
        if(registeredUser != null){
            return res.status(201).send({message: "User already exists"});
        } else {
            console.log(newUser);
            let result = await newUser.save();
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

///////////
export async function deleteAll (req: any, res: Response){

    const Btoken = req.headers['authorization'];

    if(typeof Btoken !== undefined){
        req.token = Btoken;
        jwt.verify(req.token, 'mykey', async(error: any, authData: any) => {
            if(error){
                return res.status(205).send({message: 'Authorization error'});
            } else {
                try{
                    await User.findOneAndRemove({username: req.params.username});
                   // await feedPublication.deleteFeedbyUser({username: req.params.username});
                    //await feedPublication.find({feedPublication: req.params.username});
                    await offer.find({offer: req.params.username});
                    
                    return res.status(200).send({message: "Data erased correctly"});
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
    let{username, password, fullname, description, university, degree, role, subjectsDone, subjectsRequested, phone, profilePhoto} = req.body;
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
        phone: phone,
        profilePhoto: profilePhoto};
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

export async function getUniversities(req: any, res: Response){

    let listUniversities:any[] = await University.find();
    const Btoken = req.headers['authorization'];
    if(typeof Btoken !== undefined){
        req.token = Btoken;
        jwt.verify(req.token, 'mykey', async(error: any, authData: any) => {
            if(error){
                return res.status(205).send({message: 'Authorization error'});
            } else {
                try{
                    if(listUniversities.length!=0){
                        return res.status(200).header('Content Type - application/json').send(listUniversities);
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

export async function getDegrees(req: any, res: Response){
    let schoolParam = req.params.school;
    let school = await Faculty.findOne({name: schoolParam});
    const Btoken = req.headers['authorization'];
    if(typeof Btoken !== undefined){
        req.token = Btoken;
        jwt.verify(req.token, 'mykey', async(error: any, authData: any) => {
            if(error){
                return res.status(205).send({message: 'Authorization error'});
            } else {
                try{
                    if(school != null){
                        return res.status(200).header('Content Type - application/json').send(school);
                    } else {
                        return res.status(201).send({message: "School not found"});
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

export async function getSubjects(req: any, res: Response){
    let degreeParam = req.params.degree;
    console.log(degreeParam);
    let degree = await Degree.findOne({name: degreeParam});
    console.log(degree?.toJSON.toString);
    const Btoken = req.headers['authorization'];
    if(typeof Btoken !== undefined){
        req.token = Btoken;
        jwt.verify(req.token, 'mykey', async(error: any, authData: any) => {
            if(error){
                return res.status(205).send({message: 'Authorization error'});
            } else {
                try{
                    if(degree != null){
                        return res.status(200).header('Content Type - application/json').send(degree);
                    } else {
                        return res.status(201).send({message: "Degree not found"});
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


export async function updateFollowers (req: any, res: Response){
    let{follower, followed} = req.body;
    const Btoken = req.headers['authorization'];
    const action = req.params.action;


    if(typeof Btoken !== undefined){
        req.token = Btoken;
        jwt.verify(req.token, 'mykey', async(error: any, authData: any) => {
            if(error){
                return res.status(205).send({message: 'Authorization error'});
            } else {
                try {
                    console.log('The user ' + follower + ' is trying to follow ' + followed);
                    const userfollowing = await User.findOne({username: follower});
                    const userfollowed = await User.findOne({username: followed});
                    let following = userfollowing?.following;
                    let followers = userfollowed?.followers;
                    console.log('following: ' + following);
                    console.log('followers: ' + followers);
                    if (action=='follow'){
                        followers?.push(follower);
                        following?.push(followed);
                        console.log('new following: ' + following);
                        console.log('new followers: ' + followers);
                        await User.findOneAndUpdate({username: follower}, {following: following})
                        await User.findOneAndUpdate({username: followed}, {followers: followers})
                        return res.status(200).send({message: 'Followers correctly updated'});
                    } else if (action=='unfollow') {
                        const followerIndex = findUsername(follower, followers);
                        const followingIndex = findUsername(followed, following);
                        if(followerIndex != null && followingIndex != null){
                            followers?.splice(followerIndex, 1);
                            following?.splice(followingIndex, 1);
                            console.log('new following: ' + following);
                            console.log('new followers: ' + followers);
                            await User.findOneAndUpdate({username: follower}, {following: following})
                            await User.findOneAndUpdate({username: followed}, {followers: followers})
                            return res.status(200).send({message: 'Followers correctly updated'});
                        }
                    }
                } catch {
                    return res.status(201).send({message: "Followers couldn't be updated"});
                }
            }
        });
    } else {
        return res.status(204).send({message: 'Unauthorized'});
    }

}

export async function getUserImage (req: any, res: Response){
    let username = req.params.username;
    const Btoken = req.headers['authorization'];

    if(typeof Btoken !== undefined){
        req.token = Btoken;
        jwt.verify(req.token, 'mykey', async(error: any, authData: any) => {
            if(error){
                return res.status(205).send({message: 'Authorization error'});
            } else {
                try {
                    let user = await User.findOne({username: username});
                    let userImage = user?.profilePhoto;
                    return res.status(200).send(userImage);
                } catch {
                    return res.status(201).send({message: "Database error while trying to find profile photo"});
                }
            }
        });
    } else {
        return res.status(204).send({message: 'Unauthorized'});
    }
}

function findUsername(username: String, list:any){
    for(var count=0;count<list?.length;count++){
        if(list[count] == username){
            return count;
        }
    }
}

