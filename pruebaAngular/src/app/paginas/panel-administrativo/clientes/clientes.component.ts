import { Component, OnInit } from '@angular/core';
import { ClienteService } from '../../../servicios/cliente.service';
import { ModalService } from '../../../servicios/modal.service';
import { CrearEditarComponent } from './crear-editar/crear-editar.component';

@Component({
  selector: 'app-clientes',
  templateUrl: './clientes.component.html',
  styleUrl: './clientes.component.scss'
})
export class ClientesComponent implements OnInit {
  clientes: any[] = [];
  filtro: string = '';

  constructor(private clienteService: ClienteService,
    private modalService: ModalService
    ) {}

  ngOnInit(): void {
    this.clientes = this.clienteService.obtenerClientes();
    this.clienteService.actualizarCli$.subscribe(() => {
      // Lógica para actualizar la tabla de clientes
      this.clientes = this.clienteService.obtenerClientes();
    });
  }

  nuevoCliente(): void {
    // Lógica para abrir el popup de nuevo cliente (implementa según tu necesidad)
    const modalRef = this.modalService.abrirModal(CrearEditarComponent, false);
    
  }

  editarCliente(cliente: any): void {
    // Lógica para abrir el popup de edición de cliente (implementa según tu necesidad)
    const modalRef = this.modalService.abrirModal(CrearEditarComponent, true, cliente);
  }

  eliminarCliente(cliente: any): void {
    // Lógica para eliminar cliente y actualizar la lista
    this.clienteService.eliminarCliente(cliente.id);
    this.clientes = this.clienteService.obtenerClientes();
  }
}
