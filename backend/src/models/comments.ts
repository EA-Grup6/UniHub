import {Schema,model,Document} from 'mongoose';

const schema = new Schema({
    feedId: String,
    username: String,
    publicationDate: Date,
    content: String,
    likes: Array,
}, {collection: 'comments'});

interface IComment extends Document {
    feedId: string;
    username: string;
    publicationDate: Date;
    content: string;
    likes: Array<string>;
}

export default model<IComment>('CommentPublication',schema);