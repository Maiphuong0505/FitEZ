import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr";

// Connects to data-controller="datepicker-workout-plan"
export default class extends Controller {
  connect() {
    const now = new Date()
    flatpickr(this.element, {
      dateFormat: "Y-m-d",
      mode: "range",
      minDate: "today",
      disableMobile: "true",
    })
    console.log("buddah workout plan")
  }
}
