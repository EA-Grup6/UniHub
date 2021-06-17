import {Request, Response} from 'express'
import User from '../models/User'
import CommentPublication from '../models/comments'

import jwt from 'jsonwebtoken'
import feedPublication from '../models/feedPublication'


export async function createComment (req: any, res: Response){
    const Btoken = req.headers['authorization'];
    const idFeed = req.params.feedId

    if(typeof Btoken !== undefined){
        req.token = Btoken;
        jwt.verify(req.token, 'mykey', async(error: any, authData: any) => {
            if(error){
                return res.status(205).send({message: 'Authorization error'});
            } else {
                
                let {feedId, username, content, publicationDate} = req.body;
                let newComment = new CommentPublication;
                newComment.feedId = feedId;
                newComment.content= content;
                newComment.publicationDate= publicationDate;
                newComment.username=username;

                newComment.likes= [];
                try{
                    let commentMod = await newComment.save();
                    let feedModify = await feedPublication.findOne({_id: idFeed});
                    let comments = feedModify?.comments;
                    comments?.push(newComment._id);
                    try{
                        await feedPublication.findOneAndUpdate({_id: idFeed}, {comments: comments});
                        return res.status(200).header('Content Type - application/json').send(newComment);
                    } catch {

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

export async function deleteComment (req: any, res: Response){
    const Btoken = req.headers['authorization'];

    if(typeof Btoken !== undefined){
        req.token = Btoken;
        jwt.verify(req.token, 'mykey', async(error: any, authData: any) => {
            if(error){
                return res.status(205).send({message: 'Authorization error'});
            } else {
                try{
                    let commentToRemove = await CommentPublication.findOne({_id: req.params.id});
                    await CommentPublication.findOneAndRemove({_id: req.params.id});
                    let feedPub = await feedPublication.findOne({_id: commentToRemove?.feedId})
                    let commentList = feedPub?.comments;
                    commentList?.splice(commentList?.findIndex(findUsername),1);
                    await feedPublication.findOneAndUpdate({_id: feedPub?.id}, {comments: commentList})
                    return res.status(200).send({message: "Comment correctly deleted"});
                } catch {
                    return res.status(500).send({message: "Internal server error"});
                }
            }
        });
    } else {
        return res.status(204).send({message: 'Unauthorized'});
    }
    
}


export async function getComments (req: any, res: Response){
    const Btoken = req.headers['authorization'];
    let feedId = req.params.feedId;

    if(typeof Btoken !== undefined){
        req.token = Btoken;
        jwt.verify(req.token, 'mykey', async(error: any, authData: any) => {
            if(error){
                return res.status(205).send({message: 'Authorization error'});
            } else {

                try{
                    var comments = await CommentPublication.find({feedId: feedId})
                    

                    if (comments.length !=0){
                        return res.status(200).header('Content Type - application/json').send(comments);

                    }else{
                        return res.status(204).send({message: "There aren't any feeds my dear"});
                }} catch {
                    return res.status(500).send({message: "Internal server error"});
                }
            }
        });
    } else {
        return res.status(204).send({message: 'Unauthorized'});
    }

}

export async function updateComment (req: any, res: Response){
    let{_id, Content } = req.body;
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
                    await CommentPublication.findByIdAndUpdate({_id: _id}, updateData)
                    return res.status(200).send({message: 'Comment correctly updated'});
                } catch {
                    return res.status(201).send({message: "Comment couldn't be updated"});
                }
            }
        });
    } else {
        return res.status(204).send({message: 'Unauthorized'});
    }

}

export async function updateLikesComment (req: any, res: Response){
    let{username, _id} = req.body;
    const Btoken = req.headers['authorization'];
    const action = req.params.action;


    if(typeof Btoken !== undefined){
        req.token = Btoken;
        jwt.verify(req.token, 'mykey', async(error: any, authData: any) => {
            if(error){
                return res.status(205).send({message: 'Authorization error'});
            } else {
                try {
                    const comment = await CommentPublication.findById({_id: _id});
                    let liking = comment?.likes
                    if (action=='add'){
                        liking?.push(username)
                        await CommentPublication.findByIdAndUpdate({_id: _id}, {likes: liking})
                        return res.status(200).send({message: 'FeedLikes correctly updated'});
                    }else{
                        liking?.splice(liking?.findIndex(findUsername),1);
                        await CommentPublication.findByIdAndUpdate({_id: _id}, {likes: liking})
                        return res.status(200).send({message: 'FeedLikes correctly updated'});
                    }
                } catch {
                    return res.status(201).send({message: "CommentLikes couldn't be updated"});
                }
            }
        });
    } else {
        return res.status(204).send({message: 'Unauthorized'});
    }

}

function findUsername(username: String, liking:any){
    for(var count=0;count<liking?.length;count++){
        if(liking[count] == username){
            return count;
        }
    }
}

function findComment(commentId: String, commentList:any){
    for(var count=0;count<commentList?.length;count++){
        if(commentList[count] == commentId){
            return count;
        }
    }
}
