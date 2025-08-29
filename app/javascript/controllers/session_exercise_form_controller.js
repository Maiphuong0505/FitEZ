import { Controller } from "@hotwired/stimulus";
import TomSelect from "tom-select";

// Connects to data-controller="form-prevent-default"
export default class extends Controller {
  static targets = ["tomSelect"];

  reset() {
    console.log("reset");
    console.log(this.element);
    this.element.reset();
    if (this.tomSelect) {
      this.tomSelect.clear();
    }
  }

  connect() {
    if (this.hasTomSelectTarget) {
      this.tomSelect = new TomSelect(this.tomSelectTarget, {
        theme: "bootstrap5",
        create: false,
        allowEmptyOption: true,
        placeholder: "Search exercises...",
        dropdownParent: "body",
        sortField: {
          field: "text",
          direction: "asc",
        },
      });
    }
  }
}
