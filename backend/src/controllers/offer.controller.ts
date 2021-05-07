import {Request, Response} from 'express'
import User from '../models/User'
import Offer from '../models/offer'
import FeedPublication from '../models/feedPublication'
import jwt from 'jsonwebtoken'
import offer from '../models/offer'

export async function createOffer (req: any, res: Response){
    const Btoken = req.headers['authorization'];

    if(typeof Btoken !== undefined){
        req.token = Btoken;
        jwt.verify(req.token, 'mykey', async(error: any, authData: any) => {
            if(error){
                return res.status(205).send({message: 'Authorization error'});
            } else {
                
                let {username, title, content, publicationDate, university, subject, price, type} = req.body;
                let newOffer = new offer;
                newOffer.username= username;
                newOffer.title =title;
                newOffer.content= content;
                newOffer.publicationDate= publicationDate;
                newOffer.university=university;
                newOffer.subject=subject;
                newOffer.price=price;
                newOffer.type=type;
                newOffer.likes=[];
                newOffer.comments=[];

                try{

                    let result = await newOffer.save();
                    return res.status(200).send({message: "Offer Publicado correctamente"});
                } catch {
                    return res.status(500).send({message: "Internal server error"});
                }
            }
        });
    } else {
        return res.status(204).send({message: 'Unauthorized'});
    }

}

export async function deleteOffer (req: any, res: Response){
    const Btoken = req.headers['authorization'];

    if(typeof Btoken !== undefined){
        req.token = Btoken;
        jwt.verify(req.token, 'mykey', async(error: any, authData: any) => {
            if(error){
                return res.status(205).send({message: 'Authorization error'});
            } else {
                try{
                    await Offer.findOneAndRemove({_id: req.params.id});
                    return res.status(200).send({message: "Offer correctly deleted"});
                } catch {
                    return res.status(500).send({message: "Internal server error"});
                }
            }
        });
    } else {
        return res.status(204).send({message: 'Unauthorized'});
    }
}

export async function getOffer (req: any, res: Response){
    const Btoken = req.headers['authorization'];
    let username= req.params.username;

    if(typeof Btoken !== undefined){
        req.token = Btoken;
        jwt.verify(req.token, 'mykey', async(error: any, authData: any) => {
            if(error){
                return res.status(205).send({message: 'Authorization error'});
            } else {
                const userfound = await User.findOne({username: username});
                try{
                    if(userfound != null){
                        const offers = await Offer.find(username)
                        if (offers!=null){
                            return res.status(200).header('Content Type - application/json').send(offers);
                        }else
                        return res.status(204).send({message: "U have no offers my dear"});
            
                    } else {
                        return res.status(404).send({message: "User not found"});
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

//Por asignaturas que busco? por following?
export async function getOffers (req: any, res: Response){
    const Btoken = req.headers['authorization'];
    var following = req.body;
    const offers: Offer[]=[];
    

    if(typeof Btoken !== undefined){
        req.token = Btoken;
        jwt.verify(req.token, 'mykey', async(error: any, authData: any) => {
            if(error){
                return res.status(205).send({message: 'Authorization error'});
            } else {

                try{
                    let cont= 0
                    while(cont<following.length){
                        let username= following[cont]
                        var offer= await Offer.find({username: username})
                        if (offer!= null){
                            let cont2= 0
                            while(cont2<offer.length){
                                offers.push(offer[cont2])
                            }

                        }
                        cont++
                    }
                    

                    if (offers.length !=0){
                        return res.status(200).header('Content Type - application/json').send(offers);

                    }else
                        return res.status(404).send({message: "Your friends haven't posted yet"});

                } catch {
                    return res.status(500).send({message: "Internal server error"});
                }
            }
        });
    } else {
        return res.status(204).send({message: 'Unauthorized'});
    }
}

export async function updateOffer (req: any, res: Response){
    let{username, title, content, price } = req.body;
    const Btoken = req.headers['authorization'];
    const updateData = {
        title: title,
        content: content,
        price: price,
    }

    if(typeof Btoken !== undefined){
        req.token = Btoken;
        jwt.verify(req.token, 'mykey', async(error: any, authData: any) => {
            if(error){
                return res.status(205).send({message: 'Authorization error'});
            } else {
                try {
                    await Offer.findOneAndUpdate({username: username}, updateData);
                    return res.status(200).send({message: 'Offer correctly updated'});
                } catch {
                    return res.status(201).send({message: "Offer couldn't be updated"});
                }
            }
        });
    } else {
        return res.status(204).send({message: 'Unauthorized'});
    }

}