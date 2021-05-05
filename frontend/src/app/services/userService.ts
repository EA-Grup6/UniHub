import { Injectable } from '@angular/core';
import {Environment} from "./environment";
import { HttpClient } from '@angular/common/http';
import {User} from '../models/user'

@Injectable({
  providedIn: 'root'
})
export class UserService {
  selectedUser: User;
  users: User[];
  url: Environment;

  constructor(private http: HttpClient) {
    this.selectedUser = new User();
    this.url = new Environment();
  }

  loginUser(user: User){
    return this.http.post(this.url.urlUser + '/loginUser/', user);
  }

  newUser(user: User){
    return this.http.post(this.url.urlUser + '/newUser/', user);
  }
  
  deleteUser(_username: String){
    return this.http.delete(this.url.urlUser + '/deleteUser' + `/${_username}`);
  }

  getUsers(){
    return this.http.get<User[]>(this.url.urlUser + '/getUsers/');
  }
  
  //isAdminst(_id: String){
   // return this.http.get<User>(this.url.urlUser +'/getAdmin'+`/${_id}`);
  //}
}