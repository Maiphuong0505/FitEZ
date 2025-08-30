import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  staticTargets = ["button"]

  connect() {
    // this.scrollFunction = this.scrollFunction.bind(this)
  }

  scrollFunction() {
    console.log("Hello")
    if ( window.scrollY > 200 ) {
      this.buttonTarget.remove("d-none")
    } else {
      this.buttonTarget.add("d-none")
    }
  }

  scrollToTop() {
    console.log("Hello")
    window.scrollTo ({
      top: 0,
      behavior: "smooth"
    })
  }
}
