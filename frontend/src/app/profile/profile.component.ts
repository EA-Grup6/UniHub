import { Component, OnInit } from '@angular/core';
import {User} from "../models/user";
import {userService} from "../services/userService";
import {MAT_DIALOG_DATA, MatDialog, MatDialogRef} from '@angular/material/dialog';
import {MatSnackBar} from '@angular/material/snack-bar';
import {FormBuilder, FormControl, FormGroup, Validators} from "@angular/forms";
import {Router} from "@angular/router";
import {HttpErrorResponse} from "@angular/common/http";

@Component({
  selector: 'app-profile',
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.css']
})
export class ProfileComponent implements OnInit {

  user: User;
  profileForm: FormGroup;
  validation_messages: any;



  constructor(private userService: userService, private router: Router,
              public dialog: MatDialog, private formBuilder: FormBuilder) {
  }

  ngOnInit() {
    let user = new User();
  }

  private static handleError(err: HttpErrorResponse) {
    if ( err.status === 500 ) {
      alert('Ha ocurrido un error al crear la asignatura');
    }
  }

}
