import {Request, Response} from 'express'
import User from '../models/User'
import Offer from '../models/offer'
import FeedPublication from '../models/feedPublication'

import jwt from 'jsonwebtoken'


export async function createFeed (req: any, res: Response){
    const Btoken = req.headers['authorization'];

    if(typeof Btoken !== undefined){
        req.token = Btoken;
        jwt.verify(req.token, 'mykey', async(error: any, authData: any) => {
            if(error){
                return res.status(205).send({message: 'Authorization error'});
            } else {
                
                let {content, publicationDate, username} = req.body;
                let newFeed = new FeedPublication;
                newFeed.content= content;
                newFeed.publicationDate= publicationDate;
                newFeed.username=username;

                newFeed.likes= [];
                //newFeed.comments= [];
                try{

                    let result = await newFeed.save();
                    return res.status(200).send({message: "Feed Publicado correctamente"});
                } catch {
                    return res.status(500).send({message: "Internal server error"});
                }
            }
        });
    } else {
        return res.status(204).send({message: 'Unauthorized'});
    }

}

export async function deleteFeed (req: any, res: Response){
    const Btoken = req.headers['authorization'];

    if(typeof Btoken !== undefined){
        req.token = Btoken;
        jwt.verify(req.token, 'mykey', async(error: any, authData: any) => {
            if(error){
                return res.status(205).send({message: 'Authorization error'});
            } else {
                try{
                    await FeedPublication.findOneAndRemove({_id: req.params.id});
                    return res.status(200).send({message: "Feed correctly deleted"});
                } catch {
                    return res.status(500).send({message: "Internal server error"});
                }
            }
        });
    } else {
        return res.status(204).send({message: 'Unauthorized'});
    }
    
}

export async function getFeed (req: any, res: Response){
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
                        const feeds = await FeedPublication.find(username)
                        if (feeds!=null){
                            return res.status(200).header('Content Type - application/json').send(feeds);
                        }else
                        return res.status(204).send({message: "U have no feeds my dear"});
            
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

//arreglar getfeeds con localstorage
export async function getFeeds (req: any, res: Response){
    const Btoken = req.headers['authorization'];
    var following = req.body;
    const feeds: any[]=[];
    

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
                        var feed= await FeedPublication.find({username: username})
                        if (feed!= null){
                            let cont2= 0
                            while(cont2<feed.length){
                                feeds.push(feed[cont2])
                            }

                        }
                        cont++
                    }
                    

                    if (feeds.length !=0){
                        return res.status(200).header('Content Type - application/json').send(feeds);

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

export async function updateFeed (req: any, res: Response){
    let{username, Content } = req.body;
    const Btoken = req.headers['authorization'];
    const updateData = {
        content: Content,
    }

    if(typeof Btoken !== undefined){
        req.token = Btoken;
        jwt.verify(req.token, 'mykey', async(error: any, authData: any) => {
            if(error){
                return res.status(205).send({message: 'Authorization error'});
            } else {
                try {
                    await User.findOneAndUpdate({username: username}, updateData);
                    return res.status(200).send({message: 'Feed correctly updated'});
                } catch {
                    return res.status(201).send({message: "Feed couldn't be updated"});
                }
            }
        });
    } else {
        return res.status(204).send({message: 'Unauthorized'});
    }

}

