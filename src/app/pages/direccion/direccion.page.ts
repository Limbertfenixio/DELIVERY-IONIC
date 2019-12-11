import { Component, OnInit, ElementRef, ViewChild } from '@angular/core';
import { Geolocation, Geoposition } from '@ionic-native/geolocation/ngx';
import { GoogleMap, GoogleMaps, GoogleMapsEvent, GoogleMapOptions, MarkerOptions, LatLng, Geocoder, GeocoderRequest, GeocoderResult, Marker } from '@ionic-native/google-maps/ngx';
import { ModalController, Platform } from '@ionic/angular';
import { ActivatedRoute, Router } from '@angular/router';

declare var plugin : any;

@Component({
  selector: 'app-direccion',
  templateUrl: './direccion.page.html',
  styleUrls: ['./direccion.page.scss'],
})
export class DireccionPage implements OnInit {
/*
  lat : number;
  lon : number;
  map : GoogleMap;

  constructor(private geolocation : Geolocation, private googleMaps : GoogleMaps, private modalCtrl: ModalController) { }

  ngOnInit() {
    this.geolocation.getCurrentPosition({
      enableHighAccuracy : true
      }).then((geo: Geoposition) => {
      this.loadMap(geo.coords.latitude, geo.coords.longitude);

    
    }).catch((error) => {
      console.log(error)
    });  
    this.loadMap();
  }

  loadMap(){

    let mapOptions: GoogleMapOptions = {
      camera: {
        target: {
          lat: 43.0741904, // default location
          lng: -89.3809802 // default location
        },
        zoom: 18,
        tilt: 30
      }
    };
    var mapElement = document.getElementById('map');
    this.map = GoogleMaps.create('map', mapOptions);

    // Wait the MAP_READY before using any methods.
    this.map.one(GoogleMapsEvent.MAP_READY)
    .then(() => {
      // Now you can use all methods safely.
      this.getPosition();
    })
    .catch(error =>{
      console.log(error);
    });

  }

  getPosition(): void{
    this.map.getMyLocation()
    .then(response => {
      this.map.moveCamera({
        target: response.latLng
      });
      this.map.addMarker({
        title: 'My Position',
        icon: 'blue',
        animation: 'DROP',
        position: response.latLng
      });
    })
    .catch(error =>{
      console.log(error);
    });
  }

  }*/
  @ViewChild('map', null) mapElement;

  map : GoogleMap;
  prevPosition : Geoposition; 
  tel = null;
  dir = null;
  ct = null;
  cli = null;
  ad = 1;
  up = null;
  card = null;
  pos : any = [];
  dirla :null;
  dirlo: null;
  dirlaold : null;
  dirloold : null;
  //mapElement : any
  
  constructor(private platform: Platform,private geolocation: Geolocation, private activeR : ActivatedRoute, private route: Router, private geocoder: Geocoder) {}

  async ngOnInit(){
    await this.platform.ready();
    this.tel = this.activeR.snapshot.params.tel;
    this.dir = this.activeR.snapshot.params.dir;
    this.ct = this.activeR.snapshot.params.cont;
    this.cli = this.activeR.snapshot.params.cli;
    this.ad = this.activeR.snapshot.params.ad;
    this.dirla = this.activeR.snapshot.params.dirla;
    this.dirlo = this.activeR.snapshot.params.dirlo;
    this.dirlaold = this.activeR.snapshot.params.dirla;
    this.dirloold = this.activeR.snapshot.params.dirlo;
    this.up = this.activeR.snapshot.params.up;
    this.card = this.activeR.snapshot.params.card;
    this.mapElement = document.getElementById('map');
    await this.getUserPosition();
  }

  getUserPosition(){
    this.geolocation.getCurrentPosition({
      enableHighAccuracy : true
      }).then((pos : Geoposition) => {   

        console.log(pos);
        this.pos = {
          latitude : pos.coords.latitude,
          longitude : pos.coords.longitude
        }
        //this.setMap(pos.coords.latitude,pos.coords.longitude);
        this.loadMap(pos.coords.latitude,pos.coords.longitude);
    },(err : PositionError)=>{
        console.log("error : " + err.message);
    ;
    })

    
  }

  setMap(lat , lon){
    console.log(lat)
    console.log(lon)
    
    let controls : any = {compass: true , myLocationButton: true, indoorPicker: true, zoom: true,
                          mapTypeControl : true, streetViewControl : true}

    this.map = new GoogleMap(this.mapElement, {
      'backgroundColor' : 'white',
      'controls' : {
        'compass' : controls.compass,
        'myLocationButton' : controls.myLocationButton,
        'indoorPicker' : controls.indoorPicker,
        'zoom' : controls.zoom,
        'mapTypeControl' : controls.mapTypeControl,
        'streestViewControl' : controls.streetViewControl
      },
      'gestures' : {
        'scroll' : true,
        'tilt' : true,
        'rotate' : true,
        'zoom' : true
      },
      'camera' : {
        'target': {
          lat: +lat, 
          lng: +lon
        },
        'tilt': 30,
        'zoom': 18,
      }
    });
  }


  loadMap(lat , lon){
    
    /*this.map.on(GoogleMapsEvent.MAP_READY).subscribe(
      (map) => {
        this.map.clear();
        this.map.off();
        this.map.setMapTypeId(plugin.google.maps.MapTypeId.ROADMAP);
        this.map.setMyLocationEnabled(true);
      },(error)=>{
        console.error("Error:", error);
      }
    );*/
    this.map = GoogleMaps.create('map', {
      camera: {
        target: { "lat": +lat, "lng": +lon },
        zoom: 18
      },
      controls :{
        'compass' : true,
        'myLocationButton' : true,
        'indoorPicker' : false,
        'zoom' : true,
        'mapTypeControl' : true,
        'streestViewControl' : false
      },
      gestures: {
        'scroll' : true,
        'tilt' : true,
        'rotate' : true,
        'zoom' : true
      }
    });

    this.map.addMarker({
      "position" : { "lat": +lat, "lng": +lon }
    })

    Geocoder.geocode({
      "position": { "lat": +lat, "lng": +lon }
    }).then((results: GeocoderResult[]) => {
      if (results.length == 0) {
        // Not found
        return null;
      }
      let address: any = [
        results[0].subThoroughfare || "",
        results[0].thoroughfare || "",
        results[0].locality || "",
        results[0].adminArea || "",
        results[0].postalCode || "",
        results[0].country || ""].join(", ");
      this.setGeo(lat,lon);
    });

    this.map.on(GoogleMapsEvent.MAP_CLICK).subscribe((params:any[]) => {
      let latLng: LatLng = params[0];
      let marker : Marker =  this.map.addMarkerSync({
        "position": latLng
      });
  
      Geocoder.geocode({
        "position": latLng
      }).then((results: GeocoderResult[]) => {
        if (results.length == 0) {
  
          return null;
        }
        let address: any = [
          results[0].subThoroughfare || "",
          results[0].thoroughfare || "",
          results[0].locality || "",
          results[0].adminArea || "",
          results[0].postalCode || "",
          results[0].country || ""].join(", ");
  
        marker.setTitle(address);
        marker.showInfoWindow();
        this.pos = latLng;
        this.setGeo(latLng.lat, latLng.lng);
      });
    });    

    let markOptions : MarkerOptions = {
      position: this.pos,
      title: 'prueba'
    }

    //this.addMarker(markOptions);
  }

  diss(){
    this.route.navigate(['/pedidos-chat', this.tel, this.cli ,this.ct, this.dir , this.dirlaold, this.dirloold, this.ad, this.up, 1]);
  }

  accept(){
    this.route.navigate(['/pedidos-chat', this.tel, this.cli ,this.ct , this.dir, this.dirla, this.dirlo ,this.ad, this.up, 1]);
  }

  addMarker(options){
    let marker : MarkerOptions = {
      position : new LatLng(this.pos.latitude,this.pos.longitude),
      title : options.title
    };
    this.geoCode(marker);
    this.map.addMarker(marker).then( (marker) => {
      this.geoCode(marker);
    })
  }

  geoCode(marker){
    let request : GeocoderRequest = {
      position : new LatLng(this.pos.latitude, this.pos.longitude),
    };

                          
  }
  
  setGeo(lat , lon ){
    this.dirla = lat;
    this.dirlo = lon;
  }
}
