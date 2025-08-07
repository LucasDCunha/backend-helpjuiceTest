import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input"]

  connect() {
    this.timer = null
  }

  submit() {
    clearTimeout(this.timer)
    this.timer = setTimeout(() => {
      this.element.requestSubmit()
    }, 200)
  }
}
