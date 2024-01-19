import { Component, Input } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ModalService } from '../../../../servicios/modal.service';
import { ClienteService } from '../../../../servicios/cliente.service';

@Component({
  selector: 'app-crear-editar',
  templateUrl: './crear-editar.component.html',
  styleUrl: './crear-editar.component.scss'
})
export class CrearEditarComponent {
  @Input() isEdit: boolean = false;
  @Input() cuerpoCliente: any = {};
  titulo: string = '';
  formulario!: FormGroup;

  ngOnInit() {
    if(this.isEdit){
      this.titulo = 'ACTUALIZANDO';
      this.formulario.setValue(
        {
          cedula: this.cuerpoCliente.cedula,
          nombre: this.cuerpoCliente.nombre,
          apellido: this.cuerpoCliente.apellido,
          direccion: this.cuerpoCliente.direccion,
          telefono: this.cuerpoCliente.telefono,
        }
      );
    }else{
      this.titulo = 'CREANDO';
    }
  }

  constructor(
    private fb: FormBuilder,
    private mS: ModalService,
    private cS: ClienteService
    ) {
    this.inicializarFormulario();
  }

  getErrorMensaje(controlName: string): string | null {
    const control = this.formulario.get(controlName);

    if (control && control.invalid && (control.dirty || control.touched)) {
      const errors = control.errors;
      if(errors){
        if (errors['required']) {
          return 'Este campo es obligatorio.';
        } else if (errors['pattern']) {
          return 'El formato no es válido.';
        }
      }
      // Agrega más condiciones según tus necesidades.

      // Si no coincide con ninguno de los errores conocidos, puedes devolver un mensaje genérico.
      return 'Campo no válido.';
    }

    return null;
  }

  tieneErrores(controlName: string): boolean {
    const control = this.formulario.get(controlName);

    if (!control) {
      throw new Error(`El control '${controlName}' no se encuentra en el formulario.`);
    }

    return control.invalid && (control.dirty || control.touched);
  }

  inicializarFormulario(): void {
    this.formulario = this.fb.group({
      cedula: ['', [Validators.required, Validators.pattern(/^\d{10}$/)]],
      nombre: ['', [Validators.required, Validators.pattern(/^[a-zA-Z ]{1,25}$/)]],
      apellido: ['', [Validators.required, Validators.pattern(/^[a-zA-Z ]{1,40}$/)]],
      direccion: ['', [Validators.required]],
      telefono: ['', [Validators.required, Validators.pattern(/^09\d{8}$/)]],
    });
  }

  guardar(): void {
    let cliente = {
      cedula: this.formulario.get('cedula')?.value,
      nombre: this.formulario.get('nombre')?.value,
      apellido: this.formulario.get('apellido')?.value,
      direccion: this.formulario.get('direccion')?.value,
      telefono: this.formulario.get('telefono')?.value,
    }

    this.cS.agregarCliente(cliente);
    this.cS.notificarActualizacion();
    this.cerrar();
  }

  editar(): void {
    let cliente = this.cuerpoCliente;
    Object.assign(cliente, {
      cedula: this.formulario.get('cedula')?.value,
      nombre: this.formulario.get('nombre')?.value,
      apellido: this.formulario.get('apellido')?.value,
      direccion: this.formulario.get('direccion')?.value,
      telefono: this.formulario.get('telefono')?.value,
    });
    
    this.cS.actualizarCliente(cliente);
    this.cerrar();
  }

  cerrar(): void {
    this.mS.cerrarModal();
  }
}
