import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["window"]

  connect() {
  console.log("AI controller CONNECTED on:", window.location.pathname)
  }

  toggle() {
    console.log("TOGGLE FIRED")
    this.windowTarget.classList.toggle("hidden")
  }

  close() {
    console.log("CLOSE FIRED")
    this.windowTarget.classList.add("hidden")
  }
}
