"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.startConnection = void 0;
const mongoose_1 = __importDefault(require("mongoose"));
async function startConnection() {
    const db = await mongoose_1.default.connect('mongodb://127.0.0.1:27017/users-db', {
        useNewUrlParser: true,
        useFindAndModify: false
    });
    console.log('Connection to Database stablished');
}
exports.startConnection = startConnection;
