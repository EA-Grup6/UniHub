import { OnInit } from '@angular/core';
import { Component } from '@angular/core';
import { Router } from '@angular/router';
import {RegisterComponent} from './register/register.component';
import {MatDialogRef, MatDialog} from '@angular/material/dialog';
import { ProfileComponent } from './profile/profile.component';
import { User } from './models/user';


@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent{

  title = 'frontend';
  regisComp: RegisterComponent;
  isLogged = false;
  username: string;

  constructor (private router: Router, public dialog: MatDialog){}

  ngOnInit(){
  }
    onLoginClick(){
      const MatDialogRef = this.dialog.open(RegisterComponent,{
        width: 'auto',
        height: 'auto',
      });
      MatDialogRef.afterClosed().subscribe(data=>{
        this.username = data;
        console.log(this.username);
        this.isLogged=true;
        let user = new User('', this.username, '');
        new ProfileComponent(user);
        this.router.navigateByUrl('profile');
      });
    }
  }