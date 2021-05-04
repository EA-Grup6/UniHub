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
  
  deleteUser(user: User){
    return this.http.delete(this.url.urlUser + '/deleteUser/' + `/${user.username}`);
  }

  getUsers(){
    return this.http.get<User[]>(this.url.urlUser + '/getUsers/');
  }
  
}