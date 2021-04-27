import { Injectable } from "@angular/core";

@Injectable()
export class User {
  _id: String;
  username: String;
  password: String;

  constructor(_id:String = '', username:String = '', password:String = '') {
    this._id = _id;
    this.username = username;
    this.password = password
  }
}