import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form-display-toggle"
export default class extends Controller {
  static targets = ["togglableElement", "togglableForm"]

  connect() {
    console.log("hello")
  }

  fire() {
  this.togglableElementTarget.classList.toggle("d-none");
  }
}
