import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form-toggle-display"
export default class extends Controller {
  static targets = ["togglableForm"]

  connect() {
    console.log("harro sashimiiiii")
  }

  fire() {
  this.togglableFormTarget.classList.toggle("d-none");
  }
}
