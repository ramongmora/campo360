import { Controller } from "@hotwired/stimulus"

// Este controlador hace que cualquier elemento con data-controller="animal-line"
// redirija al URL definido en data-animal-line-url-value al hacer clic.

export default class extends Controller {
  static values = {
    url: String
  }

  connect() {
    // Confirmación de conexión del controlador (útil para debug)
    console.log("🐾 AnimalLineController conectado para", this.element)

    // Agrega un listener de clic al elemento principal
    this.element.addEventListener("click", this.redirect.bind(this))
  }

  redirect() {
    if (this.urlValue) {
      console.log("🔗 Redirigiendo a:", this.urlValue)
      window.location.href = this.urlValue
    } else {
      console.warn("⚠️ No se proporcionó URL para animal-line controller.")
    }
  }
}
