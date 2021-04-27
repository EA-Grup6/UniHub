import { Injector } from '@angular/core';
import { Component, Inject, Injectable, OnInit } from '@angular/core';
import { User } from '../models/user';

@Component({
  selector: 'app-profile',
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.css'],
})
@Injectable()
export class ProfileComponent implements OnInit {

  user: User;
  username: String;
  constructor(@Inject(User) user: User) {
    this.user = user;
    this.username = user.username;
  }

  ngOnInit(): void {
  }

}
