import { Component } from '@angular/core';
import { Router } from '@angular/router';

@Component({
  selector: 'app-autenticacion',
  templateUrl: './autenticacion.component.html',
  styleUrl: './autenticacion.component.scss'
})
export class AutenticacionComponent {
  usuario: string = '';
  contrasenia: string = '';

  constructor(private router: Router) {}

  autenticar() {
    // Aquí puedes realizar la validación del usuario y contraseña antes de redirigir
    // Por ejemplo, puedes comparar los valores con un conjunto predefinido
    if (this.usuario === 'admin' && this.contrasenia === 'admin') {
      // Redirigir a otra ruta
      this.router.navigate(['/paginas/panel-administrativo']);
    } else {
      alert('Usuario o contraseña incorrectos');
    }
  }
}
