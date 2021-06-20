import {Schema,model,Document} from 'mongoose';

const schema = new Schema({
    username: String,
    title: String,
    description: String,
    publicationDate: Date,
    university: String,
    subject: String,
    price: Number,
    type: String,
    buys: Number,
    likes: Array,
    lat: String,
    long: String
}, {collection: 'offers'});

interface IOffer extends Document {
    username: string;
    title: string;
    description: string;
    publicationDate: Date;
    university: string;
    subject: string;
    price: number;
    type: string;
    buys: number;
    likes: Array<string>;
    lat: string;
    long: string;
}

export default model<IOffer>('Offer',schema);