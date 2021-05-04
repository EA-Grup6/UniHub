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
});

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
    isAdmin: boolean;
    phone: string,
}

export default model<IUser>('User',schema);