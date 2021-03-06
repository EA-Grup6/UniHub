import {Component, OnInit, Output} from '@angular/core';
import {User} from '../models/user';
import {userService} from '../services/userService';
import {MatDialog, MatDialogRef} from '@angular/material/dialog';
import {FormBuilder, FormControl, FormGroup, Validators} from "@angular/forms";
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
  password2: String;
  newUserForm: FormGroup;
  loginUserForm: FormGroup;
  validation_messages: any;
  wrong_login_user = false;
  wrong_login_password = false;
  isLogged: boolean;


  constructor(private userService: userService,
              public dialog: MatDialog, private formBuilder: FormBuilder,public dialogRef: MatDialogRef<RegisterComponent>) {

    this.newUserForm = this.formBuilder.group({
      regisUsername: new FormControl('', Validators.compose([
        Validators.required,
        Validators.email,
        Validators.pattern(/[^A-Z][a-zA-Z][^#&<>"~;$^%{}?]{1,40}$/)])),

      regisPassword: new FormControl('', Validators.compose([
        Validators.required,
        Validators.minLength(5),
        Validators.maxLength(10)])),

      regisPassword2: new FormControl('', Validators.compose([
          Validators.required])),
    });
    this.loginUserForm = this.formBuilder.group({
      loginUsername: new FormControl('', Validators.compose([
        Validators.required,
        Validators.pattern(/[^A-Z][a-zA-Z][^#&<>"~;$^%{}?]{1,40}$/)])),

      loginPassword: new FormControl('', Validators.compose([
        Validators.required])),
    });
  }

  ngOnInit() {
    let user = new User();
    this.validation_messages = {
      username: [
        { type: 'required', message: 'Username is required' },
        { type: 'email', message: 'Not valid email format' },
        { type: 'pattern', message: 'Username must be an email and have between 1 and 40 characters' },
      ],
      password: [
        { type: 'required', message: 'Password is required' },
        { type : 'minLength', message: 'Password must be 5 characters minimum'},
        { type : 'maxLength', message: 'Password must be 10 characters maximum'}
      ],
    };
  }

  addUser(){
    let user = new User();
    user.username = this.newUserForm.get('regisUsername').value;
    user.password = this.newUserForm.get('regisPassword').value;
    console.log(user.username);
    this.userService.newUser(user)
      .subscribe( res => {
        console.log("Res " + res);
        this.newUserForm.reset();
      },
      err => {
        console.log("Err: " + err);
        RegisterComponent.handleError(err);
      })
  }

  registerUser(){
    let user = new User();
    user.username = this.loginUserForm.get('loginUsername').value;
    user.password = this.loginUserForm.get('loginPassword').value;
    this.wrong_login_user = false;
    this.wrong_login_password = false;
    console.log(user.username);
    this.userService.loginUser(user)
      .subscribe( res => {
        let code = res.toString();
        if(code == '200'){
          this.closeDialogAndReturn(this.loginUserForm.get('loginUsername').value);
        }
        else if(code == '201'){
          this.wrong_login_password = true;
        }
        else if(code == "404"){
          this.wrong_login_user = true;
        }
      },
      err => {
        console.log("Err: " + err);
        RegisterComponent.handleError(err);
      })
  }

  private static handleError(err: HttpErrorResponse) {
    if ( err.status === 500 ) {
      alert('Error');
    }
  }

  closeDialog(){
    //If operation is canceled the dialog closes without returning any students
    this.dialogRef.close();
  }

  closeDialogAndReturn(username:String){
    //If operation is canceled the dialog closes without returning any students
    this.dialogRef.close(username);
  }

}
