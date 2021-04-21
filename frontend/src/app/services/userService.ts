import { Injectable } from '@angular/core';
import {Environment} from "./environment";
import { HttpClient } from '@angular/common/http';
import User from '../models/user'

@Injectable({
  providedIn: 'root'
})
export class schoolService {

  url: Environment;

  constructor(private http: HttpClient) {
    this.url = new Environment();
  }

  loginUser(){
    return this.http.post(this.url.urlUser + '/loginUser', {User});
  }

  newUser(){
    return this.http.post(this.url.urlUser + '/newUser', {User});
  }

  deleteUser(){
    return this.http.post(this.url.urlUser+'/deleteUser/', {User});
  }

}