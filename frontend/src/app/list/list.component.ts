import { User } from './../models/user';
import { UserService } from '../services/userService';
import { Component, OnInit } from '@angular/core';
import { NgForm } from "@angular/forms";
import { HttpErrorResponse } from '@angular/common/http';

@Component({
  selector: 'app-list',
  templateUrl: './list.component.html',
  styleUrls: ['./list.component.css'],
  providers: [UserService],
})
export class ListComponent implements OnInit {

  constructor(private userService: UserService) { }

  users: User[];
  user: User;
  currentUser: User;

  ngOnInit(): void {
    this.getUsers();
  }

  updateInfo(){
    this.userService.getUsers().subscribe(users=>{this.users = users});
  }

  public institutionSelect(user){
    this.currentUser = user;
  }

  /*public deleteUser(username: string) {
    if (confirm("Are you sure you want to delete it?")) {
      this.userService.deleteUser(username).subscribe((res) => {
        this.getUsers();
      });
    }
  }*/

  public deleteUser(){
    let user = new User();
    user = this.currentUser;
    this.userService.deleteUser(this.currentUser)
      .subscribe (res => {
        console.log('Res' + res);
        this.updateInfo();
      },      
      err => {
        console.log(err);
        ListComponent.handleError(err);
      });
  }

  public getUsers() {
    this.userService.getUsers().subscribe((res) => {
      this.users = res;
      console.log(this.users);
    });
  }

  private static handleError(err: HttpErrorResponse) {
    if ( err.status === 500 ) {
      alert('Ha ocurrido un error al crear la lista de usuarios');
    }
  }

}
