import {Schema,model,Document} from 'mongoose';

const schema = new Schema({
    username: String,
    password: String,
    tag: String,

});

interface IUser extends Document {
    username: string;
    password: string;
    tag:string
}



export default model<IUser>('User',schema);