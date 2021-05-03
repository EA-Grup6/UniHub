import { User } from './../models/user';
import { UserService } from '../services/UserService';
import { Component, OnInit } from '@angular/core';
import { NgForm } from "@angular/forms";

@Component({
  selector: 'app-list',
  templateUrl: './list.component.html',
  styleUrls: ['./list.component.css'],
  providers: [UserService],
})
export class ListComponent implements OnInit {

  constructor(private userService: UserService) { }

  ngOnInit(): void {
    this.getUsers();
  }

  deleteUser(username: string) {
    if (confirm("Are you sure you want to delete it?")) {
      this.userService.deleteUser(username).subscribe((res) => {
        this.getUsers();
      });
    }
  }

  getUsers() {
    this.userService.getUsers().subscribe((res) => {
      this.userService.users = res;
    });
  }



}
