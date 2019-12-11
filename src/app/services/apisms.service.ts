import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Token } from '../models/token';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class ApismsService {

  constructor(private httpClient : HttpClient) { }

  PHP_API_SERVER = "https://slottest.000webhostapp.com/textmagic";
  //PHP_API_SERVER = "http://192.168.0.13/textmagic";

  sendMessage(mensaje: Token): Observable<Token>{
    return this.httpClient.post<Token>(`${this.PHP_API_SERVER}/indexsms.php`, mensaje);
  }

}
