import { Token } from './../../models/token';
import { Component, OnInit } from '@angular/core';
import { NavParams, ModalController, AlertController } from '@ionic/angular';
import { ApiService } from 'src/app/services/api.service';
import { Client } from 'src/app/models/client';
import { ModalpagoPage } from '../modalpago/modalpago.page';

@Component({
  selector: 'app-modalconfirmacion',
  templateUrl: './modalconfirmacion.page.html',
  styleUrls: ['./modalconfirmacion.page.scss'],
})
export class ModalconfirmacionPage implements OnInit {

  dataPedido: any = [];
  dataPedidoDetalle: any = [];
  dataMenu: any = [];
  idpedido : number = 0;
  idCliente : number = 0;
  idToken : number = 0;
  idTokenF : number = 0;
  codigoVerif = null;
  codigoOk : boolean = false;
  tel : number = 0;
  token : number = 0;
  
  constructor(private navParams : NavParams, private modalCtrl: ModalController, private apiService: ApiService, private alertCtrl: AlertController) { }

  ngOnInit() {
    this.dataPedido = this.navParams.get('dataPedido');
    this.dataPedidoDetalle = this.navParams.get('dataPedidoDetalle');
    this.dataMenu = this.navParams.get('dataMenu');
    this.idpedido = this.navParams.get('idpedido');
    this.tel = this.navParams.get('celular');
    this.token = this.navParams.get('token');
  }

  async confirmPedido(){
    this.apiService.readToken().subscribe( async(token: Token[]) => {
      token.forEach(element => {
        if(this.token == this.codigoVerif && element.telefono == this.tel){
          this.codigoOk = true;
          this.idToken = element.id;
        }
        if(element.token == this.token){
          this.idTokenF = element.id;
        } 
      });
      
      if(this.codigoOk){
        console.log('sd' + this.codigoOk)
        await this.apiService.createPedido(this.dataPedido).subscribe();
        await this.apiService.updateMenu(this.dataMenu).subscribe();
        console.log(this.dataPedido)
        console.log(this.dataMenu)
        this.apiService.deleteToken(this.idToken).subscribe();
        await this.apiService.createPedidoDetalle(this.dataPedidoDetalle).subscribe();
        this.modalPago();
        this.codigoOk = false;
      }else{
        this.codigoFail('CODIGO ERRONEO' , 'El codigo de verificación que ha introducido es incorrecto');
        this.deleteToken(this.idTokenF);
      }
    });
    this.modalCtrl.dismiss();
  }

  deleteToken(id){
    setTimeout( () => {
      this.apiService.deleteToken(id).subscribe();
    }, 180000);
  }

  async modalPago(){
    const modal = await this.modalCtrl.create({
      component: ModalpagoPage,
      componentProps: {
        'idpedido' : this.idpedido
      },
      backdropDismiss: false,
      cssClass: 'modalpago'
    })

    return await modal.present();
  }


  async codigoFail(title, message){
    const alert = await this.alertCtrl.create({
      header: title,
      message : message,
      buttons: [{
        text : "Aceptar",
        role: "cancel",
        handler: () => {

        }
      }]
    });

    await alert.present();
  }

}
