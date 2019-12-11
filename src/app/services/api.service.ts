import { Token } from './../models/token';
import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Horario } from '../models/horario';
import { Client } from '../models/client';
import { Plato } from '../models/platos';
import { Menu } from '../models/menu';
import { Detalle } from '../models/detalle';
import { Producto } from '../models/producto';
import { Pedido } from '../models/pedido';
import { Pedidodetalle } from '../models/pedidodetalle';
import { Delivery } from '../models/delivery';
import { Deliveryubicacion } from '../models/deliveryubicacion';

@Injectable({
  providedIn: 'root'
})
export class ApiService {
  headers = new HttpHeaders();

  constructor(private httpClient : HttpClient) { 
    this.headers.append("Accept", '*');
    this.headers.append('Content-Type', 'application/json');
    this.headers.append('Access-Control-Allow-Origin', '*');
    this.headers.append('X-Requested-With', 'XMLHttpRequest');
  }

  options = {
    headers: {
      'Content-Type' : 'application/json',
      'Accept' : '*',
      'Access-Control-Allow-Origin' : '*',
      'X-Requested-With' : 'XMLHttpRequest'
    }
  }

  PHP_API_SERVER = "https://slottest.000webhostapp.com/API_REST_ALMULINE";
  //PHP_API_SERVER = "http://192.168.0.13/API_REST_ALMULINE";

  readHorario() : Observable<Horario[]>{
    return this.httpClient.get<Horario[]>(`${this.PHP_API_SERVER}/horario/read.php`);
  }

  readClient() : Observable<Client[]>{
    return this.httpClient.get<Client[]>(`${this.PHP_API_SERVER}/client/read.php`);
  }

  readPlatos() : Observable<Plato[]>{
    return this.httpClient.get<Plato[]>(`${this.PHP_API_SERVER}/platos/read.php`);
  }

  readMenu() : Observable<Menu[]>{
    return this.httpClient.get<Menu[]>(`${this.PHP_API_SERVER}/menu/read.php`);
  }

  readDetalle() : Observable<Detalle[]>{
    return this.httpClient.get<Detalle[]>(`${this.PHP_API_SERVER}/detalle/read.php`);
  }

  readProducto() : Observable<Producto[]>{
    return this.httpClient.get<Producto[]>(`${this.PHP_API_SERVER}/productos/read.php`);
  }
  
  readPedido() : Observable<Pedido[]>{
    return this.httpClient.get<Pedido[]>(`${this.PHP_API_SERVER}/pedidos/read.php`);
  }

  readToken() : Observable<Token[]>{
    return this.httpClient.get<Token[]>(`${this.PHP_API_SERVER}/token/read.php`);
  }

  readDelivery() : Observable<Delivery[]>{
    return this.httpClient.get<Delivery[]>(`${this.PHP_API_SERVER}/delivery/read.php`);
  }

  readDeliveryUbicacion () : Observable<Deliveryubicacion[]>{
    return this.httpClient.get<Deliveryubicacion[]>(`${this.PHP_API_SERVER}/deliveryubicacion/read.php`);
  }

  createClient(cliente: Client) : Observable<Client>{
    return this.httpClient.post<Client>(`${this.PHP_API_SERVER}/client/create.php`, cliente);
  }

  createPedido(pedido : Pedido) : Observable<Pedido>{
    return this.httpClient.post<Pedido>(`${this.PHP_API_SERVER}/pedidos/create.php`, pedido);
  }

  createPedidoDetalle(pedidoDetalle : Pedidodetalle) : Observable<Pedidodetalle>{
    return this.httpClient.post<Pedidodetalle>(`${this.PHP_API_SERVER}/pedidodetalle/create.php`, pedidoDetalle);
  }

  createToken(token : Token) : Observable<Token>{
    return this.httpClient.post<Token>(`${this.PHP_API_SERVER}/token/create.php`, token);
  }

  updateClient(cliente: Client){
    return this.httpClient.put<Client>(`${this.PHP_API_SERVER}/client/update.php`, cliente);
  }

  updateMenu(menu: Menu){
    return this.httpClient.put<Menu>(`${this.PHP_API_SERVER}/menu/update.php`, menu);
  }

  deleteToken(id: number){
    return this.httpClient.delete<Token>(`${this.PHP_API_SERVER}/token/delete.php/?id=${id}`);
  }
}
