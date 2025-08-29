import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr";

// Connects to data-controller="datepicker-workout-session"
export default class extends Controller {
  connect() {
    const now = new Date()
    flatpickr(this.element, {
      enableTime: true,
      dateFormat: "Y-m-d H:i",
      disableMobile: "true",
      // minDate: "today",
      time_24hr: true,
      minTime: "7:00",
      maxTime: "21:00",
    })
    console.log("shitake workout session")
  }
}
