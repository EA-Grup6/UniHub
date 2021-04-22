import { OnInit } from '@angular/core';
import { Component } from '@angular/core';
import { Router } from '@angular/router';
import {RegisterComponent} from './register/register.component';
import {MatDialogRef, MatDialog} from '@angular/material/dialog';
import { ProfileComponent } from './profile/profile.component';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent{

  title = 'frontend';
  isLogged = false;

  constructor (private router: Router, public dialog: MatDialog){}

  ngOnInit(){
  }

  onLoginClick(){
    const MatDialogRef = this.dialog.open(RegisterComponent,{
      width: '100%',
      height: '100%'
    });
    MatDialogRef.afterClosed().subscribe(data=>{
      console.log(data);
      this.isLogged = true;
    });
  }
}