import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  connect() {
    // this.scrollFunction = this.scrollFunction.bind(this)
  }

  scrollFunction() {
    console.log("Scroll")
    if ( window.scrollY > 200 ) {
      this.element.classList.remove("d-none")
    } else {
      this.element.classList.add("d-none")
    }
  }

  scrollToTop() {
    console.log("Back")
    window.scrollTo ({
      top: 0,
      behavior: "smooth"
    })
  }
}
