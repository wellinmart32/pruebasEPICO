import { Component } from '@angular/core';
import { Router } from '@angular/router';

@Component({
  selector: 'app-panel-administrativo',
  templateUrl: './panel-administrativo.component.html',
  styleUrl: './panel-administrativo.component.scss'
})
export class PanelAdministrativoComponent {
  constructor(private router: Router) {}
}
