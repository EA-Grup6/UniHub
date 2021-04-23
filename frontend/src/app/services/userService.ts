import { Injectable } from '@angular/core';
import {Environment} from "./environment";
import { HttpClient } from '@angular/common/http';
import {Hospital} from '../models/hospital'

@Injectable({
  providedIn: 'root'
})
export class userService {

  url: Environment;

  constructor(private http: HttpClient) {
    this.url = new Environment();
  }

  listHospital(hospital: Hospital){
    return this.http.post(this.url.urlUser + '/listHospital/', hospital);
  }

  newHospital(hospital: Hospital){
    return this.http.post(this.url.urlUser + '/newHospital/', hospital);
  }

  deleteHospital(hospital: Hospital){
    return this.http.post(this.url.urlUser + '/deleteHospital/', hospital);
  }

}