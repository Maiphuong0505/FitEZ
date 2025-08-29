import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="form-prevent-default"
export default class extends Controller {

  reset() {
    console.log("reset forms");
    console.log(this.element);
    this.element.reset();
  }
}
