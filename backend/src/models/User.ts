import {Schema,model,Document} from 'mongoose';

const schema = new Schema({
    username: String,
    password: String,
    fullname: String,
    description: String,
    university: String,
    degree: String,
    role: String,
    subjectsDone: String,
    subjectsRequested: String,
    recommendations: String,
    phone: String,
    isAdmin: Boolean,
    followers: Array,
    following: Array
}, {collection: 'users'});

interface IUser extends Document {
    username: string;
    password: string;
    fullname: string;
    description: string,
    university: string,
    degree: string,
    role: string,
    subjectsDone: string,
    subjectsRequested: string,
    recommendations: string,
    isAdmin: Boolean;
    phone: string,
    followers: Array<string>;
    following: Array<string>;
}

export default model<IUser>('User',schema);