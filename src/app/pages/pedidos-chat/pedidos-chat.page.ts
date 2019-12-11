import { Component, OnInit, ViewChild } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { PhotoViewer } from '@ionic-native/photo-viewer/ngx';
import { File } from '@ionic-native/file/ngx';
import * as moment from 'moment';
import { IonContent, AlertController } from '@ionic/angular';
import { ModalController, Platform } from '@ionic/angular';
import { GoogleMap, GoogleMaps } from '@ionic-native/google-maps/ngx';
import { Geolocation, Geoposition } from '@ionic-native/geolocation/ngx';
import { ApiService } from 'src/app/services/api.service';
import { Plato } from 'src/app/models/platos';
import { Client } from 'src/app/models/client';
import { Menu } from 'src/app/models/menu';
import { Token } from './../../models/token';
import { Detalle } from 'src/app/models/detalle';
import { Pedido } from 'src/app/models/pedido';
import { ModalconfirmacionPage } from '../modalconfirmacion/modalconfirmacion.page';
import { ApismsService } from 'src/app/services/apisms.service';

@Component({
  selector: 'app-pedidos-chat',
  templateUrl: './pedidos-chat.page.html',
  styleUrls: ['./pedidos-chat.page.scss'],
})
export class PedidosChatPage implements OnInit {

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
  isprod = false;
  dataCliente : any = [];
  dataPedidoDetalle : any = [];
  dataPedido : any = [];
  dataMenu : any = [];
  dataPlatosSeg : any = [{nombre: ''}];
  dataPlatosSop : any = [{nombre: ''}];
  dataSms : any = [];

  idMenu :number = 0;
  idplatos : any = [];
  conts = 0
  conto = 0
  cantidadMenu = 0;

  idCliente : number = 0;
  idProducto : number = 0;
  idpedido : number = 0;
  producto : string = '';
  descrip : null;
  costo : number = 0;
  subtotal : 0;
  token : number = Math.floor(Math.random() * (1000 - 200) + 1000);
  isToken = false;

  constructor(private platform: Platform,private apiSmsService: ApismsService ,private geolocation : Geolocation,private activeR : ActivatedRoute, private route : Router, private photo: PhotoViewer, private file : File, private alertCtrl: AlertController, private modalCtrl: ModalController ,private apiService : ApiService) { }

  async ngOnInit() {
    //await this.platform.ready();
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

    console.log(this.dirla)
    this.bottom();
  }


  mainMenu(){
    this.apiService.readMenu().subscribe( (menus : Menu[]) => {
      for(let menu of menus){
        if(menu.idproducto == this.idProducto){
          //this.isprod = true;
        }
      }
      for(let menu of menus){
        if(menu.fecha == this.fech && menu.idempresa == 1 && menu.idproducto == this.idProducto){
          console.log('hoy')
          this.isprod = true;
          this.cantidadMenu = menu.cantidad;
          this.linkImage = 'https://slottest.000webhostapp.com/img/' + menu.fotomenu + '.jpg';
          //this.linkImage = 'http://192.168.0.13/almuonline/img/' + menu.fotomenu + '.jpg';
          this.costo = menu.precio;
          this.idMenu = menu.idprodmen;        
          this.apiService.readDetalle().subscribe( (detalles: Detalle[]) => {
            this.idplatos.splice(0, this.idplatos.length)
            for(let detalle of detalles){
              if(detalle.idprodmen == menu.idprodmen){
                this.idplatos.push({id: detalle.idplato}) //this.idplatos.push()    
              }
            }

            console.log(this.dataPlatosSeg)
              this.apiService.readPlatos().subscribe( (platos : Plato[]) => {
                this.dataPlatosSeg.splice(0, this.dataPlatosSeg.length);
                this.dataPlatosSop.splice(0, this.dataPlatosSop.length);
                this.conto = 0;
                this.conts = 0;
                console.log(this.dataPlatosSeg.length)
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
          });
          this.vmenu = true;
          break;
        }
      }
      
      if(this.isprod == false){
        this.menuNull();
        this.vmenu = false;
      }
    });
    this.isprod = false;
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
    console.log(this.cantidadMenu)
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

  confirm(){
    this.dataCliente = {
      idcliente : this.id,
      nombrecliente : this.cli,
      celular : this.tel,
      direccion : this.dir,
      latitud : this.dirla,
      longitud : this.dirlo,
      referencia : 'Ninguna'
    }

    console.log(this.up)
    if(this.up == 1){
      this.apiService.updateClient(this.dataCliente).subscribe();
    }else{
      this.apiService.createClient(this.dataCliente).subscribe();
    }
    
    console.log(this.id)
    this.confirmPedido();
  };

  confirmPedido(){
    this.apiService.readPedido().subscribe( (pedidos: Pedido[]) => {
      pedidos.forEach(element => {
        if(element.idpedido == this.idpedido){
          this.idpedido = Math.floor(Math.random() * (100000 - 20000) + 100000); 
        }
      })
    });

    this.apiService.readClient().subscribe(async (clientes : Client[]) => {
      clientes.forEach(element => {
        this.idCliente = element.idcliente;
      })
      if(this.id == 0){
        this.id = this.idCliente;
        this.confirmAddPedido(Number(this.id) + 1);
        console.log('no');
        console.log(this.id)
      }else{
        this.confirmAddPedido(this.id);
      }
    });
  }

  async confirmAddPedido(id){
    var sub = this.costo * this.cant;
    this.idpedido = Math.floor(Math.random() * (100000 - 20000) + 100000); 
    this.dataSms = {
      celular : '591' + this.tel,
      telefono : this.tel,
      token : this.token,
      estado : "env"
    }

    console.log(this.dataSms);

    this.apiService.readToken().subscribe( (token: Token[]) => {
      token.forEach(element => {
        if(element.token == this.token){
          this.isToken = true;
        }
      });
      if(!this.isToken){
        this.apiSmsService.sendMessage(this.dataSms).subscribe();
        this.apiService.createToken(this.dataSms).subscribe();
      }
      this.isToken = false;
    });

    this.dataPedido = {
      idpedido : this.idpedido,
      idcliente : id,
      idprodmenu : this.idMenu,
      estado : 'preparacion',
      fechapedido : this.fech,
      horapedido : this.time,
      usuadd : 3
    }

    this.dataPedidoDetalle = {
      idpedido : this.idpedido,
      producto : this.producto,
      descripedido : this.descrip,
      cantidad : this.cant,
      costo : this.costo,
      subtotal : sub,
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
    const modal = await this.modalCtrl.create({
      component: ModalconfirmacionPage,
      componentProps : {
        'dataPedido' : this.dataPedido,
        'dataPedidoDetalle' : this.dataPedidoDetalle,
        'dataMenu' : this.dataMenu,
        'idpedido' : this.idpedido,
        'celular' : this.tel,
        'token' : this.token
      },
      backdropDismiss : false,
      cssClass : 'modalconfirmacion'
    });

    return await modal.present();
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
      message : 'Estimado cliente aun no se publico el menu para el dia de hoy, por favor vuelva a intentarlo mas tarde',
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
