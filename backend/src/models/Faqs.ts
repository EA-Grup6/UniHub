import {Schema,model,Document} from 'mongoose';

const schema = new Schema({
    question: String,
    answer: String,
}, {collection: 'faqs'});

interface IFaqs extends Document {
    question: String;
    answer: String;
}

export default model<IFaqs>('Faqs',schema);