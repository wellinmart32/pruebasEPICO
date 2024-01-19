import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { PanelAdministrativoComponent } from './panel-administrativo.component';
import { InicioComponent } from './inicio/inicio.component';
import { ClientesComponent } from './clientes/clientes.component';

const routes: Routes = [
  {
    path: '',
    component: PanelAdministrativoComponent,
    children: [
      { path: 'inicio', 
        loadChildren: () => import('./inicio/inicio.module').then(
        (m) => m.InicioModule
      ),
      },
      { path: 'clientes', 
        loadChildren: () => import('./clientes/clientes.module').then(
          (m) => m.ClientesModule
        ),
      },
      {
        path: '',
        redirectTo: 'inicio',
        pathMatch: 'full'
      }
    ]
  },

];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class PanelAdministrativoRoutingModule { }
