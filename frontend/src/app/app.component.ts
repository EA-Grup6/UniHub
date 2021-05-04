import { OnInit } from '@angular/core';
import { Component } from '@angular/core';
import { NavigationEnd, Router } from '@angular/router';
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
  isAdmin = false;

  constructor (private router: Router, public dialog: MatDialog){}

  ngOnInit(){
  }
    onLoginClick(){
      const MatDialogRef = this.dialog.open(RegisterComponent,{
        width: 'auto',
        height: 'auto',
      });
      MatDialogRef.afterClosed().subscribe(data=>{
        this.isAdmin = data;
        //console.log(this.username);
        if(data != null){
          this.isLogged=true;
        }
      });
    }
    onLogoutClick(){
      this.isLogged = false;
      this.username=null;
      this.router.navigateByUrl('');
      this.isAdmin = false;
    }
    onManageClick(){
      this.router.navigateByUrl('admin');
    }
  }