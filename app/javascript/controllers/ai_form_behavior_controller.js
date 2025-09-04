import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="ai-form-behavior"
export default class extends Controller {
  connect() {
    console.log("Hitachi Honda Toyota")
  }

  submit() {
    this.element.classList.add("d-none");
  }

  cancel(event) {
    event.preventDefault();
    this.element.remove();
  }
}
