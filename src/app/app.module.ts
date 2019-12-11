import { FormsModule } from '@angular/forms';
import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { RouteReuseStrategy } from '@angular/router';

import { IonicModule, IonicRouteStrategy } from '@ionic/angular';
import { SplashScreen } from '@ionic-native/splash-screen/ngx';
import { StatusBar } from '@ionic-native/status-bar/ngx';
import { ScreenOrientation } from '@ionic-native/screen-orientation/ngx';
import { PhotoViewer } from '@ionic-native/photo-viewer/ngx';
import { File } from '@ionic-native/file/ngx';
import { Geolocation } from '@ionic-native/geolocation/ngx';
import {GoogleMaps, Geocoder} from '@ionic-native/google-maps/ngx';

import { AppComponent } from './app.component';
import { AppRoutingModule } from './app-routing.module';
import { SplashPage } from './pages/splash/splash.page';
import { DireccionPage } from './pages/direccion/direccion.page';
import { HttpClientModule } from '@angular/common/http';
import { from } from 'rxjs';
import { ModalpagoPage } from './pages/modalpago/modalpago.page';
import { ModalEleccionPage } from './pages/modal-eleccion/modal-eleccion.page';
import { ModalconfirmacionPage } from './pages/modalconfirmacion/modalconfirmacion.page';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { MaterialModule } from './material.module';


@NgModule({
  declarations: [AppComponent, SplashPage, ModalpagoPage, ModalEleccionPage, ModalconfirmacionPage],
  entryComponents: [SplashPage, ModalpagoPage, ModalEleccionPage, ModalconfirmacionPage],
  imports: [BrowserModule, MaterialModule ,IonicModule.forRoot(), AppRoutingModule, HttpClientModule, FormsModule, BrowserAnimationsModule],
  providers: [
    StatusBar,
    SplashScreen,
    ScreenOrientation,
    PhotoViewer,
    File,
    Geolocation,
    GoogleMaps,
    Geocoder, 
    { provide: RouteReuseStrategy, useClass: IonicRouteStrategy }
  ],
  bootstrap: [AppComponent],
  exports : [

  ]
})
export class AppModule {}
