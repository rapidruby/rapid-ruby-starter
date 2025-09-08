# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin "@rails/actiontext", to: "actiontext.js"
pin "@rails/actioncable", to: "actioncable.esm.js"
pin "@rails/activestorage", to: "activestorage.esm.js"
pin "trix"
pin "stimulus-use" # @0.52.3
pin "@rails/request.js", to: "requestjs.js"
pin_all_from "app/javascript/controllers", under: "controllers"
# pin "lodash", to: "https://esm.sh/lodash"
pin "tailwindcss-stimulus-components" # @6.1.3
