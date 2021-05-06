import {Schema,model,Document} from 'mongoose';

const schema = new Schema({
    username: String,
    title: String,
    content: String,
    publicationDate: Date,
    university: String,
    subject: String,
    price: Int16Array,
    type: String,
    comments: Array,
    likes: Array,
});

interface IOffer extends Document {
    username: string;
    title: string;
    content: string;
    publicationDate: Date;
    university: string;
    subject: string;
    price: Int16Array;
    type: String;
    comments: Array<string>;
    likes: Array<string>;
}

export default model<IOffer>('Offer',schema);