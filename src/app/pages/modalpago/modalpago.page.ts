import { Component, OnInit } from '@angular/core';
import { AlertController, NavParams, ModalController } from '@ionic/angular';
import { Router } from '@angular/router';
import { ApiService } from 'src/app/services/api.service';

@Component({
  selector: 'app-modalpago',
  templateUrl: './modalpago.page.html',
  styleUrls: ['./modalpago.page.scss'],
})
export class ModalpagoPage implements OnInit {

  np : number;
  idpedido : number;

  constructor(private alertCtrl: AlertController,private modalCtrl: ModalController, private route: Router,private navParams: NavParams, private apiService : ApiService) { }

  ngOnInit() {
    this.np =  this.navParams.get('idpedido'); 
  }

  async efectivo(){
    this.diss();
    const alert = await this.alertCtrl.create({
      header : 'Pedido Completado',
      message : 'Gracias por su compra su pedido esta en camino!!',
      buttons: [{
        text : 'Aceptar',
        handler : () => {
          this.route.navigate(['/home']);
        }
      }],
      backdropDismiss : false
    })
    await alert.present();
  }


  diss(){
    this.modalCtrl.dismiss();
  }
}
