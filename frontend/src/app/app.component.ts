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
  regisComp: RegisterComponent;
  isLogged=false;

  constructor (private router: Router, public dialog: MatDialog){}

  ngOnInit(){
  }
    onLoginClick(){
      const MatDialogRef = this.dialog.open(RegisterComponent,{
        width: 'auto',
        height: 'auto',
    
      });
      MatDialogRef.afterClosed().subscribe(data=>{
        console.log(data);
        this.isLogged=data;
      });
    }

   
  }

function onLoginClick() {
  throw new Error('Function not implemented.');
}

