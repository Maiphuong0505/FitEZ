import { Controller } from "@hotwired/stimulus"
import TomSelect from "tom-select";

// Connects to data-controller="form-prevent-default"
export default class extends Controller {
  static targets = ["tomSelect"]

  reset() {
    console.log("reset")
    console.log(this.element)
    this.element.reset()
    this.tomSelect.clear()
  }

  connect() {
    this.tomSelect = new TomSelect(this.tomSelectTarget, {
      create: true,
      sortField: {
        field: "text",
        direction: "asc",
      },
    });
  }
}
