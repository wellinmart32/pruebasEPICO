import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { ClientesRoutingModule } from './clientes-routing.module';
import { ClientesComponent } from './clientes.component';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { CrearEditarComponent } from './crear-editar/crear-editar.component';


@NgModule({
  declarations: [
    ClientesComponent,
    CrearEditarComponent
  ],
  imports: [
    CommonModule,
    ClientesRoutingModule,
    FormsModule,
    ReactiveFormsModule
  ]
})
export class ClientesModule { }
