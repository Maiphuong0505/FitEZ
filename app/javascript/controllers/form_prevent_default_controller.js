import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form-prevent-default"
export default class extends Controller {
  static target = [ "inputField" ]
  connect() {
    console.log("Harro!")
  }

  submit(event) {
    event.preventDefault()
    this.element.target.reset
  }
}
