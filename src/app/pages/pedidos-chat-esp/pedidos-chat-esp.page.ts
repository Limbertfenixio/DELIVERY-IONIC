import { Component, OnInit, ViewChild } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { PhotoViewer } from '@ionic-native/photo-viewer/ngx';
import { File } from '@ionic-native/file/ngx';
import * as moment from 'moment';
import { IonContent, AlertController } from '@ionic/angular';
import { ModalController, Platform } from '@ionic/angular';
import { DireccionPage } from '../direccion/direccion.page';
import { GoogleMap, GoogleMaps } from '@ionic-native/google-maps/ngx';
import { Geolocation, Geoposition } from '@ionic-native/geolocation/ngx';
import { ApiService } from 'src/app/services/api.service';
import { Plato } from 'src/app/models/platos';
import { Client } from 'src/app/models/client';
import { Menu } from 'src/app/models/menu';
import { Detalle } from 'src/app/models/detalle';
import { ModalpagoComponent } from 'src/app/components/modalpago/modalpago.component';
import { ModalpagoPage } from '../modalpago/modalpago.page';

@Component({
  selector: 'app-pedidos-chat-esp',
  templateUrl: './pedidos-chat-esp.page.html',
  styleUrls: ['./pedidos-chat-esp.page.scss'],
})
export class PedidosChatEspPage implements OnInit {

  @ViewChild(IonContent, null) content : IonContent;
  map: GoogleMap;
  tel = null;
  dirla = null;
  dirlo = null;
  ct = null;
  cli = null;
  id = null;
  up = null;
  card = null;
  day = moment().format('LTS');
  fech = moment().format('YYYY-MM-DD');
  time = moment().format('HH:mm:ss'); 
  linkImage : string = null;
  vmenu = false;
  vdat = false;
  vconfir = false;
  cant = 0;
  dir = null;
  np = null;
  sop = false;
  seg = false;
  dataCliente : any = [];
  dataPedido : any = [];
  dataMenu : any = [];
  dataPlatosSeg : any = [{nombre: ''}];
  dataPlatosSop : any = [{nombre: ''}];

  idMenu :number = 0;
  idplatos : any = [];
  conts = 0
  conto = 0
  cantidadMenu = 0;

  idCliente : null;
  idProducto : number = 0;
  producto : string = '';
  descrip : null;
  costo : number = 0;
  subtotal : 0;

  constructor(private platform: Platform,private geolocation : Geolocation,private activeR : ActivatedRoute, private route : Router, private photo: PhotoViewer, private file : File, private alertCtrl: AlertController, private modalCtrl: ModalController ,private apiService : ApiService) { }

  async ngOnInit() {
    await this.platform.ready();
    this.tel = this.activeR.snapshot.params.tel;
    this.dirla = this.activeR.snapshot.params.dirla;
    this.dirlo = this.activeR.snapshot.params.dirlo;
    this.cant = this.activeR.snapshot.params.cont;
    this.cli = this.activeR.snapshot.params.cli;
    this.id = this.activeR.snapshot.params.id;
    this.dir = this.activeR.snapshot.params.dir;
    this.up = this.activeR.snapshot.params.up;
    this.card = this.activeR.snapshot.params.card;
    this.vmenu = false;
    this.vdat = false;
    
    if(this.card == 1){
      this.vmenu = true;
      this.vdat = true;
    }

    console.log(this.fech)
    if(this.id == 0){
      this.geolocation.getCurrentPosition({
        enableHighAccuracy : true
        }).then((pos : Geoposition) => {   
  
          console.log(pos);
          this.dirla = pos.coords.latitude;
            
          this.dirlo = pos.coords.longitude;
  
      },(err : PositionError)=>{
          console.log("error : " + err.message);
      ;
      });
    }else{
      await this.loadMap();
    }

    

    
    console.log(this.dataPlatosSeg)
    this.bottom();
  }


  mainMenu(){
    this.apiService.readMenu().subscribe( (menus : Menu[]) => {
      for(let menu of menus){
        if(menu.fecha == this.fech && menu.idempresa == 1 && menu.idproducto == this.idProducto){
          console.log('hoy')
          this.linkImage = 'http://192.168.1.213/almuonline/img/' + menu.fotomenu + '.jpg';
          this.costo = menu.precio;
          this.idMenu = menu.idprodmen;
          console.log(this.linkImage)
          console.log(menu.fotomenu);
          this.apiService.readDetalle().subscribe( (detalles: Detalle[]) => {
            for(let detalle of detalles){
              if(detalle.idprodmen == menu.idprodmen){
                this.idplatos.push({id: detalle.idplato}) //this.idplatos.push()    
              }
            }
            if(this.dataPlatosSeg.length < 2 && this.dataPlatosSop.length < 2){
              this.apiService.readPlatos().subscribe( (platos : Plato[]) => {
                for(let plato of platos){ 
                  for(let idp of this.idplatos){
                    if(plato.tipo == 'Segundos' && plato.idplatos == idp.id){
                      console.log(plato.nombre)
                      this.conts = this.conts + 1;
                      
                        this.dataPlatosSeg.push({idplatos:plato.idplatos ,nombre: plato.nombre})
                       
                    } 
                    if(plato.tipo == 'Sopas' && plato.idplatos == idp.id){
                      console.log(plato.nombre)
                      this.conto = this.conto + 1;
                      this.dataPlatosSop.push({idplatos:plato.idplatos ,nombre: plato.nombre})
                    } 
                  }
                }
                //this.dataPlatosSeg = platos;
              });
            } 
          });
          this.vmenu = true;
          break;
        }else{
          this.menuNull();
          this.vmenu = false;
          
          break;
        };

        this.cantidadMenu = menu.cantidad;
      }
      
    });
  }

  menu(producto){
    switch (producto) {
      case 1:
          this.producto = 'ALMUERZO TRADICIONAL';
          this.idProducto = 1;
        break;
      case 2:
          this.producto = 'ALMUERZO VEGETARIANO';
          this.idProducto = 2;
          break;
      case 3: 
          this.producto = 'ALMUERZO ESPECIAL';
          this.idProducto = 3;
          break;
      default:
        break;
    }
    this.mainMenu();
    this.bottom();
  }

  orden(){
    if(this.cantidadMenu >= this.cant){
      this.bottom();
      this.vdat = true;
      this.loadMap();
    }else{
      this.cantidadExedida();
    }
    
  }

  cont(param){
    if(param == 0){
      if(this.cant == 0){
        this.cant = 0;
      }else{
        this.cant--;
      }
    }else{
      this.cant++;
    }
  }

  almuerzo(){
    if(this.conto > 1){
      this.sop = true;
      this.seg = false;
    }
    if(this.conts > 1){
      this.seg = true;
      this.sop = false;
    }
    if(this.conts > 1 && this.conto > 1){
      this.seg = true;
      this.sop = true;
    }
    if(this.conts < 1 && this.conto < 1){
      this.seg = false;
      this.sop = false;
    }
  }

  sopa(){
    if(this.conto > 1){
      this.sop = true;
      this.seg = false;
    }else{
      this.sop = false;
      this.seg = false;
    }
    
  }

  segundo(){
    if(this.conts > 1){
      this.seg = true;
      this.sop = false;
    }else{
      this.seg = false;
      this.sop = false;
    }
  }

  preview(src){
  const ROOT_DIRECTORY = this.file.applicationStorageDirectory;
  const folder = 'temp';
  
  var options = {
      share: false, 
      closeButton: true, 
      copyToReference: true, 
      headers: '',  
      piccasoOptions: { } 
  };
  
  this.file.createDir(ROOT_DIRECTORY, folder, true).then( (root) => {
    this.file.copyFile(this.file.applicationDirectory + "www/assets/" , src , ROOT_DIRECTORY + folder + "//", src).then((root) => {
      this.photo.show(ROOT_DIRECTORY + folder + '/' + src, src , options);
    })
  });
  }


  loadMap(){
    console.log("lat" + this.dirla)
    console.log("lon" + this.dirlo)
    this.map = GoogleMaps.create('map_canvas', {
      camera: {
        target: { "lat": +this.dirla, "lng": +this.dirlo },
        zoom: 14
      },
      controls :{
        'compass' : false,
        'myLocationButton' : false,
        'indoorPicker' : false,
        'zoom' : false,
        'mapTypeControl' : false,
        'streestViewControl' : false
      },
      gestures: {
        'scroll' : false,
        'tilt' : false,
        'rotate' : false,
        'zoom' : false
      }
    });

    this.map.addMarker({
      "position" : { "lat": +this.dirla, "lng": +this.dirlo }
    })

  }

  async confirm(){
    //this.bottom();
    //this.vconfir = true;
    
    this.dataCliente = {
      idcliente : this.id,
      nombrecliente : this.cli,
      celular : this.tel,
      direccion : this.dir,
      latitud : this.dirla,
      longitud : this.dirlo,
      referencia : 'Ninguna'
    }
    console.log(this.id)
    //this.confirmPedido();

    const modal = await this.modalCtrl.create({
      component: ModalpagoPage,
      componentProps : {
        'dataCliente' : this.dataCliente,
        'up' : this.up
      },
      backdropDismiss : false,
      cssClass : 'modalpago'
    });

    return await modal.present();
  };

  confirmPedido(){
    var sub = this.costo * this.cant;
    this.dataPedido = {
      idcliente : this.id,
      idprodmenu : this.idMenu,
      producto : this.producto,
      cantidad : this.cant,
      costo : this.costo,
      subtotal : sub,
      estado : 'preparacion',
      fechapedido : this.fech,
      horapedido : this.time,
      usuadd : 3
    }

    this.dataMenu = {
      idprodmen : this.idMenu,
      idempresa : 0,
      idproducto : 0,
      nombremenu : '',
      fotomenu : '',
      fecha : '',
      cantidad : this.cantidadMenu - this.cant,
      precio : 0,
      estado: '',
      adduss : 0
    }

    this.apiService.createPedido(this.dataPedido).subscribe();
    this.apiService.updateMenu(this.dataMenu).subscribe();
  }

  async cantidadExedida(){
    const alert =  await this.alertCtrl.create({
      header: 'Cantidad Agotada',
      message : 'Lo sentimos pero no contamos con esa cantidad de platos en nuestro menu',
      buttons: [{
        text: 'Cancelar',
        role : 'cancel'
      },
      {
        text : 'Aceptar',
        handler : () => {
          console.log('aceptar')
        }
      }]
    })

    await alert.present();
  }

  async menuNull(){
    const alert = await this.alertCtrl.create({
      header: 'Menu Inexistente',
      message : 'Estimado cliente el dia de hoy no se ha publicado el menu',
      buttons : [{
        text : 'Aceptar',
        role: 'cancel'
      }]
    });

    await alert.present();
  }

  maps(){
    this.route.navigate(['/direccion', this.tel, this.cli, this.cant, this.dir, this.dirla, this.dirlo,this.id, this.up, this.card]);
  }

  diss(){
    this.route.navigate(['/home']);
  }

  
  bottom(){
    setTimeout( () => {
      this.content.scrollToBottom(1);
    }, 1000)
  }

}
