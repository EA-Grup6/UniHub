import {Request, Response} from 'express'
import User from '../models/User'
import FeedPublication from '../models/feedPublication'
import Offer from '../models/offer'
import jwt from 'jsonwebtoken';

export async function getStadistics (req: any, res: Response){

    const Btoken = req.headers['authorization'];

    if(typeof Btoken !== undefined){
        req.token = Btoken;
        jwt.verify(req.token, 'mykey', async(error: any, authData: any) => {
            if(error){
                return res.status(205).send({message: 'Authorization error'});
            } 
            else {
                try{
                    const users = await User.find();
                    const Feed = await FeedPublication.find();
                    const offers = await Offer.find();

                    const numusers = users.length;
                    const numoffers =  offers.length;
                    const numfeed =  Feed.length;

                    const body = {'numUsers': numusers.toString(), 'numFeeds': numfeed.toString(), 'numOffers': numoffers.toString()}
                    console.log(body);

                    return res.status(200).header('Content Type - application/json').send(body);
                } catch {
                    return res.status(500).send({message: "Internal server error"});
                }
            }
        });
    } else {
        return res.status(204).send({message: 'Unauthorized'});
    }
}