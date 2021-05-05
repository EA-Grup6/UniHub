import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { ProfileComponent } from './profile/profile.component';
import {RegisterComponent} from "./register/register.component";
import {ListComponent} from "./list/list.component";
import {AccountComponent} from "./account/account.component";


const routes: Routes = [

  {path: 'profile', component: ProfileComponent},
  {path: 'admin', component: ListComponent},
  {path: 'account', component: AccountComponent},

];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
