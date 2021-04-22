import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import {RegisterComponent} from "./register/register.component";
import {ProfileComponent} from "./profile/profile.component";

const routes: Routes = [
  {path: 'home', component: RegisterComponent},
  {path: 'profile', component: ProfileComponent},
  {path: '**', redirectTo: 'home'} //si se pone cualquier cosa en el navegador ira al login/register
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
