import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Routes, RouterModule } from '@angular/router';

import { IonicModule } from '@ionic/angular';

import { PedidosChatEspPage } from './pedidos-chat-esp.page';

const routes: Routes = [
  {
    path: '',
    component: PedidosChatEspPage
  }
];

@NgModule({
  imports: [
    CommonModule,
    FormsModule,
    IonicModule,
    RouterModule.forChild(routes)
  ],
  declarations: [PedidosChatEspPage]
})
export class PedidosChatEspPageModule {}
