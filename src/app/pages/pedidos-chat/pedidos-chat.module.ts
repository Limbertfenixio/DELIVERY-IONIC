import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Routes, RouterModule } from '@angular/router';

import { IonicModule } from '@ionic/angular';

import { PedidosChatPage } from './pedidos-chat.page';


const routes: Routes = [
  {
    path: '',
    component: PedidosChatPage
  }
];

@NgModule({
  imports: [
    CommonModule,
    FormsModule,
    IonicModule,
    RouterModule.forChild(routes),
  ],
  entryComponents : [],
  declarations: [PedidosChatPage],
  
})
export class PedidosChatPageModule {}
