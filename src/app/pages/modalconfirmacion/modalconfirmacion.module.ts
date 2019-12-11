import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Routes, RouterModule } from '@angular/router';

import { IonicModule } from '@ionic/angular';

import { ModalconfirmacionPage } from './modalconfirmacion.page';

const routes: Routes = [
  {
    path: '',
    component: ModalconfirmacionPage
  }
];

@NgModule({
  imports: [
    CommonModule,
    FormsModule,
    IonicModule,
    RouterModule.forChild(routes)
  ],
  entryComponents: [],
  declarations: [ModalconfirmacionPage]
})
export class ModalconfirmacionPageModule {}
