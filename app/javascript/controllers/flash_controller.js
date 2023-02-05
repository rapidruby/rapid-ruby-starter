import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flash"
export default class extends Controller {
  connect() {
    setTimeout(() => {
      this.hideAlert();
    }, 5000);
  }

  dismiss(event) {
    event.preventDefault();
    event.stopPropagation();

    this.hideAlert();
  }

  hideAlert() {
    this.element.style.display = "none";
  }
}
