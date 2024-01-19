import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { PanelAdministrativoRoutingModule } from './panel-administrativo-routing.module';
import { PanelAdministrativoComponent } from './panel-administrativo.component';


@NgModule({
  declarations: [
    PanelAdministrativoComponent
  ],
  imports: [
    CommonModule,
    PanelAdministrativoRoutingModule
  ]
})
export class PanelAdministrativoModule { }
