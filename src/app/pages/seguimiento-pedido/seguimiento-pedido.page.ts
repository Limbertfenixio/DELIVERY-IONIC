import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { ApiService } from 'src/app/services/api.service';
import { Delivery } from 'src/app/models/delivery';
import { GoogleMap, GoogleMaps } from '@ionic-native/google-maps/ngx';
import { Deliveryubicacion } from 'src/app/models/deliveryubicacion';

@Component({
  selector: 'app-seguimiento-pedido',
  templateUrl: './seguimiento-pedido.page.html',
  styleUrls: ['./seguimiento-pedido.page.scss'],
})
export class SeguimientoPedidoPage implements OnInit {

  map: GoogleMap;
  isLinear = false;
  f1 = false;
  f2 = false;
  f3 = false;
  f4 = false; 
  f5 = false;
  btnAU = true;
  cont = 0;
  nropedido = null;
  idDeliv = null;
  cliente = null;
  estado = "En preparación";
  estadoP = "Tu pedido se encuentra en preparacion";
  lat = null;
  lon = null;
  Ilatlng : any = [];

  constructor(private active : ActivatedRoute, private apiService: ApiService) { }

  async ngOnInit() {
    this.nropedido = this.active.snapshot.params.id;
    this.cliente = this.active.snapshot.params.nom;
    this.refreshEstado();
    await this.loadMapI();
  }

  refreshEstado(){
    this.apiService.readDelivery().subscribe( (deliverys : Delivery[]) => {
      deliverys.forEach( element => {
        if(element.idpedido == this.nropedido){
          this.estado = element.estado;
          this.idDeliv = element.iddeliv;
        }
      });
      this.refreshEstadoStep(this.estado);
    });
  }

  async refreshEstadoStep(estado){
    switch (estado) {
      case 'preparacion':
          this.f1 = true;
          this.f2 = false;
          this.f3 = false;
          this.f4 = false;
          this.f5 = false;
          this.btnAU = true;
          this.estadoP = "Su pedido se encuentra en preparacion";
          this.cont = 0;
          await this.loadMap(-16.495844, -68.149025);
        break;
      case 'recogido':
          this.f1 = true;
          this.f2 = true;
          this.f3 = false;
          this.f4 = false;
          this.f5 = false;
          this.btnAU = true;
          this.estadoP = "El repartidor ha recogido su pedido";
          this.cont = 1;
          await this.loadMap(-16.495844, -68.149025); 
        break;
      case 'enviado':
          this.f1 = true;
          this.f2 = true;
          this.f3 = true;
          this.f4 = false;
          this.f5 = false;
          this.btnAU = false;
          this.estadoP = "Su pedido ha sido enviado y se encuentra en camino";
          this.cont = 2;
          this.refreshMap();
        break;
      case 'contactar cliente':
          this.f1 = true;
          this.f2 = true;
          this.f3 = true;
          this.f4 = true;
          this.f5 = false;
          this.btnAU = false;
          this.estadoP = "Estimado cliente lo estamos contactando por telefono";
          this.cont = 3;
          this.refreshMap();
        break;
      case 'entregado':
          this.f1 = true;
          this.f2 = true;
          this.f3 = true;
          this.f4 = true;
          this.f5 = true;
          this.btnAU = true;
          this.estadoP = "Su pedido ya ha sido entregado";
          this.cont = 4;
          await this.loadMap(-16.495844, -68.149025);
        break;  
    }
  }

  refreshMap(){
    this.apiService.readDeliveryUbicacion().subscribe( (deliverysubicacion: Deliveryubicacion[]) => {
      deliverysubicacion.forEach(element => {
        if(element.iddeliv == this.idDeliv){
          this.lat = element.latitud;
          this.lon = element.longitud;
        }
      });
      this.loadMap(this.lat, this.lon);
    });
  }

  loadMap(lat , lon){
    this.Ilatlng = {
      lat : lat,
      lng : lon
    } 

    this.map.setOptions({
		camera : {
			'target' : this.Ilatlng,
			'zoom' : 14
		},
		controls :{
        'compass' : false,
        'myLocationButton' : true,
        'indoorPicker' : true,
        'zoom' : false,
        'mapTypeControl' : true,
        'streestViewControl' : true
		},
		gestures: {
			'scroll' : false,
			'tilt' : true,
			'rotate' : false,
			'zoom' : false
		}
	});

    this.map.clear();
	this.map.addMarker({
      "position" : this.Ilatlng
    });
  }

  loadMapI(){
	  this.map = GoogleMaps.create('map_canvas', {
	  camera: {
        zoom: 14
      },
      controls :{
        'compass' : false,
        'myLocationButton' : false,
        'indoorPicker' : true,
        'zoom' : false,
        'mapTypeControl' : true,
        'streestViewControl' : true
      },
      gestures: {
        'scroll' : false,
        'tilt' : true,
        'rotate' : false,
        'zoom' : false
      }
    });
  }

}
