import {Schema,model,Document} from 'mongoose';

const schema = new Schema({
    username: String,
    description: String,
    url: String

});

interface IHospital extends Document {
    username: string;
    description: string;
    url: string;
}

export default model<IHospital>('Hospital',schema);