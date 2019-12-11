import { Component, OnInit } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';

@Component({
  selector: 'app-menu',
  templateUrl: './menu.page.html',
  styleUrls: ['./menu.page.scss'],
})
export class MenuPage implements OnInit {

  src = null;
  tel = null;

  constructor(private route: Router, private activeR: ActivatedRoute) { }

  ngOnInit() {
    this.src = this.activeR.snapshot.params.src;
    this.tel = this.activeR.snapshot.params.tel;
  }

  cancel(){
    this.route.navigate(['/pedidos-chat' , this.tel]);
  }

}
