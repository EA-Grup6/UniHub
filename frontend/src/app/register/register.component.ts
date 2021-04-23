import {Component, OnInit} from '@angular/core';
import {Hospital} from '../models/hospital';
import {userService} from '../services/userService';
import {MatDialog, MatDialogRef, throwMatDialogContentAlreadyAttachedError} from '@angular/material/dialog';
import {FormBuilder, FormControl, FormGroup, Validators} from "@angular/forms";
import {Router} from "@angular/router";
import {HttpErrorResponse} from "@angular/common/http";
import { AppComponent } from '../app.component';

@Component({
  selector: 'app-home',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.css']
})
export class RegisterComponent implements OnInit {
  hospital: Hospital;
  username: String;
  description: String;
  url: String
  newHospitalForm: FormGroup;
  listHospitalForm: FormGroup;
  deleteHospitalForm: FormGroup;
  validation_messages: any;
  wrong_login_user = false;
  wrong_login_password = false;

  constructor(private userService: userService, private router: Router,
              public dialog: MatDialog, private formBuilder: FormBuilder,public dialogRef: MatDialogRef<RegisterComponent>) {

    this.newHospitalForm = this.formBuilder.group({
      regisUsername: new FormControl('', Validators.compose([
        Validators.required,
        Validators.pattern(/[^A-Z][a-zA-Z][^#&<>"~;$^%{}?]{1,40}$/)])),

     /* regisDescription: new FormControl('', Validators.compose([
        Validators.required])),

      regisUrl: new FormControl('', Validators.compose([
          Validators.required])),*/
    });
 
    
    this.deleteHospitalForm = this.formBuilder.group({
      deleteUsername: new FormControl('', Validators.compose([
        Validators.required,
        Validators.pattern(/[^A-Z][a-zA-Z][^#&<>"~;$^%{}?]{1,40}$/)])),

      deleteDescription: new FormControl('', Validators.compose([
        Validators.required])),
      deleteUrl: new FormControl('', Validators.compose([
         Validators.required])),
    });
  }

  ngOnInit() {
    let hospital = new Hospital();
    this.validation_messages = {
      username: [
        { type: 'required', message: 'Nombre institucion es necesario ' },      
      ],

    };
  }

  addHospital(){
    let hospital = new Hospital();
    hospital.username = this.newHospitalForm.get('regisHospital').value;
    hospital.description= this.newHospitalForm.get('regisDescription').value;
    hospital.url= this.newHospitalForm.get('regisUrl').value;
    console.log(hospital.username);
    this.userService.newHospital(hospital)
      .subscribe( res => {
        console.log("Res " + res);
        this.newHospitalForm.reset();
      },
      err => {
        console.log("Err: " + err);
        RegisterComponent.handleError(err);
      })
  }

  registerHospital(){
    let hospital = new Hospital();
    hospital.username = this.listHospitalForm.get('listHospital').value;
    hospital.description = this.listHospitalForm.get('listDescription').value;
    hospital.url = this.listHospitalForm.get('listUrl').value;
    this.wrong_login_user = false;
    this.wrong_login_password = false;
    console.log(hospital.username);
    this.userService.listHospital(hospital)
      .subscribe( res => {
        let code = res.toString();
        if(code == '200'){
          this.listHospitalForm.reset();
          this.closeDialog(res);
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

  deleteUser(){
    let hospital = new Hospital();
    hospital.username = this.deleteHospitalForm.get('deleteUsername').value;
    hospital.description = this.deleteHospitalForm.get('deleteDescription').value;
    hospital.url = this.deleteHospitalForm.get('deleteUrl').value;
    this.wrong_login_user = false;
    this.wrong_login_password = false;
    console.log(hospital.username);
    this.userService.deleteHospital(hospital)
      .subscribe( res => {
        let code = res.toString();
        if(code == '200'){
          this.deleteHospitalForm.reset();
          this.closeDialog(res);
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
      alert('Ha ocurrido un error al crear la asignatura');
    }
  }

  closeDialog(data: any){
    //If operation is canceled the dialog closes without returning any students
    this.dialogRef.close(data);
  }

}
