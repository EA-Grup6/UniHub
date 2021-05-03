import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { AppRoutingModule } from './app-routing.module';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import {MatCardModule} from "@angular/material/card";
import {MatListModule} from "@angular/material/list";
import {MatDialogModule} from "@angular/material/dialog";
import {HttpClientModule} from "@angular/common/http";
import {MatButtonModule} from "@angular/material/button";
import {MatCheckboxModule} from "@angular/material/checkbox";
import {FormsModule, ReactiveFormsModule} from "@angular/forms";
import {MatRadioModule} from "@angular/material/radio";
import {MatIconModule} from "@angular/material/icon";
import { AppComponent } from './app.component';
import { RegisterComponent } from './register/register.component';
import { MatToolbarModule } from '@angular/material/toolbar';
import { ProfileComponent } from './profile/profile.component';
import { AngularFireModule } from '@angular/fire';
import { AngularFirestoreModule } from '@angular/fire/firestore';
import { AngularFireStorageModule } from '@angular/fire/storage';
import { AngularFireAuthModule } from '@angular/fire/auth';
import { ListComponent } from './list/list.component';

// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
  apiKey: "AIzaSyApkwagvk0f4_C6ZZvKNK-ALSDFzq4HnOE",
  authDomain: "sprint0-2cdf8.firebaseapp.com",
  projectId: "sprint0-2cdf8",
  storageBucket: "sprint0-2cdf8.appspot.com",
  messagingSenderId: "659979771998",
  appId: "1:659979771998:web:97bd639aef27f59a4014cf",
  measurementId: "G-QRB59S4ZF0"
};

@NgModule({
  declarations: [
    AppComponent,
    RegisterComponent,
    ProfileComponent,
    ListComponent,
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    BrowserAnimationsModule,
    MatCardModule,
    MatListModule,
    MatDialogModule,
    HttpClientModule,
    MatButtonModule,
    MatCheckboxModule,
    FormsModule,
    MatRadioModule,
    MatIconModule,
    ReactiveFormsModule,
    MatToolbarModule,
    AngularFireModule.initializeApp(firebaseConfig),
    AngularFirestoreModule, // firestore
    AngularFireAuthModule, // auth
    AngularFireStorageModule, // storage
  ],
  exports: [
    BrowserModule,
    AppRoutingModule,
    BrowserAnimationsModule,
    MatCardModule,
    MatListModule,
    MatDialogModule,
    HttpClientModule,
    MatButtonModule,
    MatCheckboxModule,
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
