import {Component, OnInit} from '@angular/core';
import {User} from '../models/user';
import {userService} from '../services/userService';
import {MatDialog} from '@angular/material/dialog';
import {FormBuilder, FormControl, FormGroup, Validators} from "@angular/forms";
import {Router} from "@angular/router";
import {HttpErrorResponse} from "@angular/common/http";

@Component({
  selector: 'app-home',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.css']
})
export class RegisterComponent implements OnInit {
  user: User;
  username: String;
  password: String;
  newUserForm: FormGroup;
  loginUserForm: FormGroup;
  validation_messages: any;

  constructor(private userService: userService, private router: Router,
              public dialog: MatDialog, private formBuilder: FormBuilder) {

    this.newUserForm = this.formBuilder.group({
      username: new FormControl('', Validators.compose([
        Validators.required,
        Validators.pattern(/[^A-Z][a-zA-Z][^#&<>"~;$^%{}?]{1,20}$/)])),

      password: new FormControl('', Validators.compose([
        Validators.required])),
    });
    this.loginUserForm = this.formBuilder.group({
      username: new FormControl('', Validators.compose([
        Validators.required,
        Validators.pattern(/[^A-Z][a-zA-Z][^#&<>"~;$^%{}?]{1,20}$/)])),

      password: new FormControl('', Validators.compose([
        Validators.required])),
    });
  }

  ngOnInit() {
    let user = new User();
    this.validation_messages = {
      username: [
        { type: 'required', message: 'Username is required' },
        { type: 'pattern', message: 'Name must be in capital letter and have between 1 and 20 characters' },
      ],
      password: [
        { type: 'required', message: 'Password is required' }
      ],
    };
  }

  addUser(){
    let user = new User();
    user.username = this.newUserForm.get('username').value;
    user.password = this.newUserForm.get('password').value;
    console.log(user.username);
    this.userService.newUser(user)
      .subscribe( res => {
        console.log("Res " + res);
      },
      err => {
        console.log("Err: " + err);
        RegisterComponent.handleError(err);
      })
  }

  registerUser(){
    let user = new User();
    user.username = this.loginUserForm.get('username').value;
    user.password = this.loginUserForm.get('password').value;
    console.log(user.username);
    this.userService.loginUser(user)
      .subscribe( res => {
        console.log('Res: ' + res);
      },
      err => {
        console.log("Err: " + err);
        RegisterComponent.handleError(err);
      })
  }

  private static handleError(err: HttpErrorResponse) {
    if ( err.status === 500 ) {
      alert('Ha ocurrido un error al crear la asignatura');
    }
  }

}
