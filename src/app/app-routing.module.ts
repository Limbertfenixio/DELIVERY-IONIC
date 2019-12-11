import { NgModule } from '@angular/core';
import { PreloadAllModules, RouterModule, Routes } from '@angular/router';

const routes: Routes = [
  { path: '', redirectTo: 'home', pathMatch: 'full' },
  { path: 'splash', loadChildren: './pages/splash/splash.module#SplashPageModule' },
  { path: 'home', loadChildren: './pages/home/home.module#HomePageModule' },
  { path: 'pedidos-chat/:tel/:cli/:cont/:dir/:dirla/:dirlo/:id/:up/:card', loadChildren: './pages/pedidos-chat/pedidos-chat.module#PedidosChatPageModule' },
  { path: 'menu/:tel/:src', loadChildren: './pages/menu/menu.module#MenuPageModule' },
  { path: 'direccion/:tel/:cli/:cont/:dir/:dirla/:dirlo/:ad/:up/:card', loadChildren: './pages/direccion/direccion.module#DireccionPageModule' },
  { path: 'modalpago', loadChildren: './pages/modalpago/modalpago.module#ModalpagoPageModule' },
  { path: 'pedidos-chat-esp/:tel/:cli/:cont/:dir/:dirla/:dirlo/:id/:up/:card', loadChildren: './pages/pedidos-chat-esp/pedidos-chat-esp.module#PedidosChatEspPageModule' },
  { path: 'modal-eleccion', loadChildren: './pages/modal-eleccion/modal-eleccion.module#ModalEleccionPageModule' },
  { path: 'modalconfirmacion', loadChildren: './pages/modalconfirmacion/modalconfirmacion.module#ModalconfirmacionPageModule' },
  { path: 'seguimiento-pedido/:id/:nom', loadChildren: './pages/seguimiento-pedido/seguimiento-pedido.module#SeguimientoPedidoPageModule' },
];

@NgModule({
  imports: [
    RouterModule.forRoot(routes, { preloadingStrategy: PreloadAllModules })
  ],
  exports: [RouterModule]
})
export class AppRoutingModule { }
