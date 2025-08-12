import { Controller } from "@hotwired/stimulus"
// import Chartjs from "@stimulus-components/chartjs"

// import { Chart, registerables } from "chart.js"

// Chart.register(...registerables)

// // Connects to data-controller="chartjs"
// export default class extends Controller {
//   static values = {
//     weightData: Object,
//     chartjsOptions: Object
//   }
//   connect() {
//     super.connect() // important: this sets up the chart

//     console.log("Netflix and Chill")

//     this.chart = Chartjs.new(this.element.getContext("2d"), {
//       type: 'line',
//       data: this.weightDataValue,
//       options: this.chartjsOptionsValue
//     })
//   }
// }

import { Chart, registerables } from "chart.js"

Chart.register(...registerables)

// Connects to data-controller="chartjs"
export default class extends Controller {
  static values = {
    weightData: Object,
    chartjsOptions: Object
  }

  connect() {
    this.chart = new Chart(this.element, {
      type: 'line', // or 'bar', 'pie', etc.
      data: this.weightDataValue,
      options: this.chartjsOptionsValue
    })
  }

  disconnect() {
    if (this.chart) {
      this.chart.destroy()
    }
  }
}
