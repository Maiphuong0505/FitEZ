# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "bootstrap", to: "bootstrap.min.js", preload: true
pin "@popperjs/core", to: "popper.js", preload: true
pin "@stimulus-components/chartjs", to: "@stimulus-components--chartjs.js" # @6.0.1
pin "@hotwired/stimulus", to: "@hotwired--stimulus.js" # @3.2.2
pin "@kurkle/color", to: "@kurkle--color.js" # @0.3.4
pin "chart.js" # @4.5.0
