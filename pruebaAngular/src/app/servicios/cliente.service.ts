import { Injectable } from '@angular/core';
import { Subject } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class ClienteService {
  private readonly claveLocalStorage = 'clientes';
  private actualizarCli = new Subject<void>();

  actualizarCli$ = this.actualizarCli.asObservable();

  notificarActualizacion() {
    this.actualizarCli.next();
  }

  obtenerClientes(): any[] {
    const clientesStr = localStorage.getItem(this.claveLocalStorage);
    return clientesStr ? JSON.parse(clientesStr) : [];
  }

  agregarCliente(cliente: any): void {
    const clientes = this.obtenerClientes();
    cliente.id = this.generarId();
    clientes.push(cliente);
    this.actualizarClientes(clientes);
  }

  actualizarCliente(cliente: any): void {
    const clientes = this.obtenerClientes();
    const indice = clientes.findIndex(c => c.id === cliente.id);
    if (indice !== -1) {
      clientes[indice] = cliente;
      this.actualizarClientes(clientes);
    }
  }

  eliminarCliente(id: number): void {
    const clientes = this.obtenerClientes();
    const nuevosClientes = clientes.filter(c => c.id !== id);
    this.actualizarClientes(nuevosClientes);
  }

  private generarId(): number {
    const clientes = this.obtenerClientes();
    const ids = clientes.map(c => c.id);
    const nuevoId = Math.max(...ids, 0) + 1;
    return nuevoId;
  }

  private actualizarClientes(clientes: any[]): void {
    localStorage.setItem(this.claveLocalStorage, JSON.stringify(clientes));
  }
}
