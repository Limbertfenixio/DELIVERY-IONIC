import { Component, OnInit } from '@angular/core';
import { NavParams, ModalController } from '@ionic/angular';
import { ApiService } from 'src/app/services/api.service';
import { Router } from '@angular/router';
import { Client } from 'src/app/models/client';

@Component({
  selector: 'app-modal-eleccion',
  templateUrl: './modal-eleccion.page.html',
  styleUrls: ['./modal-eleccion.page.scss'],
})
export class ModalEleccionPage implements OnInit {

  cel : 0;
  clienteCel : 0;
  clienteold = false;
  constructor(private navParams : NavParams, private modalCtrl: ModalController,private apiService : ApiService, private route: Router) { }

  ngOnInit() {
    this.cel = this.navParams.get('cel');
    this.clienteCel = this.navParams.get('clientecel');
  }

  tradicional(){
    this.navigateClient(this.cel, 'tradicional');
    this,this.modalCtrl.dismiss();
  }

  especial(){
    this.navigateClient(this.cel, 'especial');
    this,this.modalCtrl.dismiss();
  }

  navigateClient(cel , button){
    console.log(cel)
    this.apiService.readClient().subscribe( async (clientes: Client[]) => {
      for (let cliente of clientes){
        if(cel == cliente.celular && button == 'tradicional'){
          this.route.navigate(['/pedidos-chat', cel, cliente.nombrecliente ,0,cliente.direccion, cliente.latitud,cliente.longitud ,cliente.idcliente,1,0]);
          console.log(cliente.celular)
          this.clienteold = true
        }
        if(cel == cliente.celular && button == 'especial'){
          this.route.navigate(['/pedidos-chat-esp', cel, cliente.nombrecliente ,0,cliente.direccion, cliente.latitud,cliente.longitud ,cliente.idcliente,1,0]);
          this.clienteold = true
        }
      }

      if(this.clienteold != true){
        if(button == 'tradicional'){
          this.route.navigate(['/pedidos-chat', cel, ' ' ,0,'', 0,0 ,0,0,0]);
          this.clienteold = true
        }
        if(button == 'especial'){
          this.route.navigate(['/pedidos-chat-esp', cel, ' ' ,0,'', 0,0 ,0,0,0]);
          this.clienteold = true
        }
      }    
      this.clienteold = false;
    })
  }

}
