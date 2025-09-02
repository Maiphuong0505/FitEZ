import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="scroll-into-view"
export default class extends Controller {
  static values = {
    scroll: Boolean
  }
  connect() {
    if (this.scrollValue) {
      this.element.scrollIntoView();
    }
  }
}
