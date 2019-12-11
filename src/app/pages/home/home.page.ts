import { Component, OnInit } from '@angular/core';
import { AlertController, ModalController } from '@ionic/angular';
import { ScreenOrientation } from '@ionic-native/screen-orientation/ngx';
import { ApiService } from 'src/app/services/api.service';
import { Horario } from 'src/app/models/horario';
import * as moment from 'moment';
import { stringify } from 'querystring';
import { Router } from '@angular/router';
import { Client } from 'src/app/models/client';
import { ModalEleccionPage } from '../modal-eleccion/modal-eleccion.page';
import { element } from 'protractor';
import { Pedido } from 'src/app/models/pedido';

@Component({
  selector: 'app-home',
  templateUrl: './home.page.html',
  styleUrls: ['./home.page.scss'],
})
export class HomePage implements OnInit {

  constructor(private alertCtrl : AlertController, private modalCtrl: ModalController,private screen : ScreenOrientation, private apiService : ApiService, private route: Router) { }

  date = "";
  time = moment().format('HH:mm:ss'); 
  libre = true;
  celerr = false;
  npediderr = false;
  idpedido = null;
  cliente = null;
  
  ngOnInit() {
    this.fech(moment().format('dddd'));
    this.screen.lock('portrait');
    console.log(this.time);
  }

  fech(fech){
    switch(fech){
      case 'Monday':
        this.date = "Lunes";
      break;
      case 'Tuesday':
        this.date = "Martes";
      break;
      case 'Wednesday':
        this.date = "Miercoles";
      break;
      case 'Thursday':
        this.date = "Jueves";
      break;
      case 'Friday':
        this.date = "Viernes";
      break;
      case 'Saturday':
        this.date = "Sabado";
      break;
      case 'Sunday':
        this.date = "Domingo";
      break;
    }
  }

  async presentAlmuerzo(){
    this.apiService.readHorario().subscribe( (horario : Horario[]) => {
      this.time = moment().format('HH:mm:ss'); 
      this.presentAlmu(horario);
    }) 
  }

  async presentGeo(){
    this.apiService.readHorario().subscribe( (horario : Horario[]) => {
      this.time = moment().format('HH:mm:ss'); 
      this.presentGeoT(horario);
    }) 
  }

  async presentAlmu(horario){
    horario.forEach(element => { 
      if(this.date == element.dia && this.time >= element.deh && this.time <= element.hastah){
        this.libre = false;
      }
    });
    if(this.libre == false){
      const alert = await this.alertCtrl.create({
        header: 'ESTIMADO CLIENTE',
        message: 'Porfavor introduzca su numero de celular',
        inputs: [{
          name : 'txtCel',
          type : 'number',
          placeholder : 'Numero de Celular'
        }] ,
        buttons : [{
          text : 'Cancelar',
          role : 'cancel',
          cssClass : 'danger',
          handler : () => {
  
          }
        },{
          text: 'Aceptar',
          handler : (data) => {
            this.presentEleccion(data.txtCel)
            //this.route.navigate(['/pedidos-chat', data.txtCel, ' ' ,0,'', 0,0 ,0]);
          }   
        }],
        cssClass : 'alert-danger' 
      });
      await alert.present();
    }else{
      const alert = await this.alertCtrl.create({
        header: 'Fuera de Atencion!',
        message: 'Estimado cliente estamos <strong>fuera de atencion</strong>!!!',
        buttons: [
           {
            text: 'Aceptar',
            handler: () => {
              console.log('Confirm Okay');
            }
          }
        ]
      });
      await alert.present();
    }
  }

  async presentEleccion(cel){
    const modal = await this.modalCtrl.create({
      component: ModalEleccionPage,
      componentProps : {
        'cel' : cel
      },
      backdropDismiss : false,
      cssClass: 'modaleleccion'
    })
    return await modal.present();
  }

  async presentGeoT(horario){
    horario.forEach(element => { 
        if(this.date == element.dia && this.time >= element.deh && this.time <= element.hastah){
          this.libre = false;
        }
    });
    if(this.libre == false){
      const alert = await this.alertCtrl.create({
        header : 'SEGIMIENTO DE PEDIDO',
        message: 'Seleccione el modo para realizar el seguimiento',
        inputs: [{
          name : 'chkNro',
          type : 'radio',
          label : 'Por numero de Pedido',
          value : '1',
          checked : true,
        },{
          name : 'chkCel',
          type : 'radio',
          label : 'Nro Celular',
          value : '2'
        }],
        buttons : [{
          text : 'Cancelar',
          role : 'cancel',
          cssClass : 'danger',
          handler : () => {
          }
        },{
          text : 'Aceptar',
          handler : (data) => {
            this.presentNum(data);
            console.log('Select: ' + data);
          }
        }],
        cssClass : 'alert-danger'
      });
      await alert.present();
    }else{
      const alert = await this.alertCtrl.create({
        header: 'Fuera de Atencion!',
        message: 'Estimado cliente estamos <strong>fuera de atencion</strong>!!!',
        buttons: [
           {
            text: 'Aceptar',
            handler: () => {
              console.log('Confirm Okay');
            }
          }
        ]
      });
      await alert.present();
    }
      
  }
 
  
  async presentNum(datas){
    var message = '';
    var placeholder = '';
    if(datas == 1){
      message = 'Introduce tu numero de Pedido';
      placeholder = 'Numero de Pedido'
    }else{
      message = 'Introduce tu numero de Celular';
      placeholder = 'Numero de Celular'
    }
    const alert = await this.alertCtrl.create({
      header : 'SEGIMIENTO DE PEDIDO',
      message: message,
      inputs: [{
        name : 'chkNro',
        type : 'number',
        id : 't',
        placeholder : placeholder,
        min : -5,
        max: 8
      }],
      buttons : [{
        text : 'Cancelar',
        role : 'cancel',
      },{
        text : 'Aceptar',
        handler : (data) => {
          if(datas == 1){
            this.apiService.readPedido().subscribe( (pedidos: Pedido[]) => {
              pedidos.forEach( element => {
                if(element.idpedido == data.chkNro){
                  this.npediderr = true;
                  this.navSP(datas, element.idpedido, element.idcliente);
                }
              });
              if(!this.npediderr){
                this.presentError('ATENCIÓN!','El número de pedido introducido no existe, para mayor información contactase con atención al cliente');
                this.npediderr = false;
              }
            });
          }
          if(datas == 2){
            this.apiService.readClient().subscribe( (clients : Client[]) => {         
              clients.forEach( element => {     
                if(element.celular == data.chkNro){
                  this.celerr = true;
                  this.navSP(datas, element.idcliente, element.nombrecliente);
                }
              });
              if(!this.celerr){
                this.presentError('ATENCIÓN!','El número introducido no tienen ningun pedido existente, para mayor información contactese con atención al cliente');
                this.celerr = false;
              }
            })
          }
        }
      }],
      cssClass : 'chk', 
    });
    document.getElementById('t').setAttribute('ng-maxlength' , '8');
    await alert.present();
  }

  navSP(datas, id, cliente){
    if(datas == 2){
      this.apiService.readPedido().subscribe( (pedidos: Pedido[]) => {
        pedidos.forEach( element => {
          if(element.idcliente == id){
            this.idpedido = element.idpedido;
          }
        });
        this.route.navigate(['/seguimiento-pedido', this.idpedido, cliente]);
      });
    }else{
      this.apiService.readClient().subscribe( (clientes: Client[]) => {
        clientes.forEach( element => {
          if(element.idcliente == cliente){
            this.cliente = element.nombrecliente;
          }
        });
        this.route.navigate(['/seguimiento-pedido', id, this.cliente]);
      });
    }
   
  }

  async presentError(header, message){
    const alert = await this.alertCtrl.create({
      header: header,
      message : message,
      buttons: [{
        text: 'Aceptar',
        role: 'cancel'
      }]
    })
    await alert.present();
  }
}
