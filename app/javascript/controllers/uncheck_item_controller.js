import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="uncheck-item"
export default class extends Controller {
  connect() {
    console.log("you touch my cha la la", this.element)
  }

  check(){
    if (this.element.checked) {
      this.element.checked = false
    }
    else {
      this.element.checked
    }
  }
}
