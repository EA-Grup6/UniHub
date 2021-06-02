import {Request, Response} from 'express'
import Faqs from '../models/Faqs'

import jwt from 'jsonwebtoken'

export async function getFaqs (req: any, res: Response){
    const Btoken = req.headers['authorization'];
    if(typeof Btoken !== undefined){
        req.token = Btoken;
        jwt.verify(req.token, 'mykey', async(error: any, authData: any) => {
            if(error){
                return res.status(205).send({message: 'Authorization error'});
            } else {
                try{
                        const faqs = await Faqs.find();
                        if (faqs!=null){
                            return res.status(200).header('Content Type - application/json').send(faqs);
                        }else
                            return res.status(204).send({message: "There aren't any faqs my dear"});
                } catch {
                    return res.status(500).send({message: "Internal server error"});
                }
            }
        });
    } else {
        return res.status(204).send({message: 'Unauthorized'});
    }
}