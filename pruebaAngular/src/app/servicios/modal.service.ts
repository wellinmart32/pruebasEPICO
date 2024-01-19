import { Injectable } from '@angular/core';
import { NgbModal } from '@ng-bootstrap/ng-bootstrap';

@Injectable({
  providedIn: 'root'
})
export class ModalService {
  modalRef: any;

  constructor(private modalService: NgbModal) {}

  abrirModal(content: any, isEdit: boolean, cliente?: any): void {
    this.modalRef = this.modalService.open(content);
    this.modalRef.componentInstance.isEdit = isEdit;
    if(cliente) {
      // logica de actualizar
      this.modalRef.componentInstance.cuerpoCliente = cliente;
    }
  }

  cerrarModal() {
    this.modalRef.close();
  }

}
  