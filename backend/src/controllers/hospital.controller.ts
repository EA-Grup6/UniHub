import {Request, Response} from 'express'
import Hospital from '../models/Hospital'

export function helloWorld(req: Request, res: Response){
    return res.send('Hello World !!!')
}
export async function createHospital (req: Request, res: Response){

    let {username, description,url} = req.body;
    let hospital = {username: username, description: description,url:url};
    let newHospital = new Hospital(hospital);
    let registeredHospital = await Hospital.findOne({username:newHospital.username})
    try{
        if(registeredHospital != null){
            return res.status(201).send({message: "User already exists"});
        } else {
            let result = newHospital.save();
            return res.status(200).send(result);
        }
    } catch {
        return res.status(500).send({message: "Internal server error"});
    }
}

export async function loginHospital (req: Request, res: Response){

    let {username, description,url} = req.body;
    const hospital = {
        username: username,
        description: description,
        url: url
    };
    console.log("Username: " + hospital.username);
    console.log("Description: " + hospital.description);
    console.log("Url: " + hospital.url);
    const registeringHospital = new Hospital(hospital);
    var registeredHospital = await Hospital.findOne({username:registeringHospital.username})
    try{
        if(registeredHospital != null){
            if(registeredHospital.get('Description') == registeringHospital.description){
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

export async function deleteHospital (req: Request, res: Response){

    const{username} = req.body;

    const registeredHospital= await Hospital.findOne({name:username});
    try{
        if(registeredHospital != null){
            Hospital.findOneAndDelete({username: registeredHospital.username});
            return res.status(200).send({message: "Hospital correctly deleted"});
        } else {
            return res.status(404).send({message: "Hospital not found"});
        }
    } catch {
        return res.status(500).send({message: "Internal server error"});
    }
}