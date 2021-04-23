import { OnInit } from '@angular/core';
import { Component } from '@angular/core';
import { Router } from '@angular/router';
import {RegisterComponent} from './register/register.component';
import {MatDialogRef, MatDialog} from '@angular/material/dialog';


@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent{

  title = 'frontend';
  loginpopup = true;
  isLogged = false;
  

  constructor (private router: Router, public dialog: MatDialog){}

  ngOnInit(){
  }
    onLoginClick(){
      if (this.loginpopup)
        {
        const MatDialogRef = this.dialog.open(RegisterComponent,{
          width: '100%',
          height: '100%'     
      
        });
        MatDialogRef.afterClosed().subscribe(data=>{
          console.log(data);
          
        this.isLogged = true;
          
        });
      }
    this.loginpopup = false;//con esto evitamos que salgan mas logins que Minions 

   }
   
  }

function onLoginClick() {
  throw new Error('Function not implemented.');
}

