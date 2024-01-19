import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

const routes: Routes = [
  {
    path: '',
    redirectTo: 'paginas/autenticacion',
    pathMatch: 'full'
  },
  { path: 'paginas/autenticacion', 
    loadChildren: () => import('./paginas/autenticacion/autenticacion.module').then(
      (m) => m.AutenticacionModule
    ),
  },
  { path: 'paginas/panel-administrativo', 
    loadChildren: () => import('./paginas/panel-administrativo/panel-administrativo.module').then(
      (m) => m.PanelAdministrativoModule
    ),
  }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
