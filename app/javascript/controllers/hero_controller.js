import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["imageWrap", "textWrap"]

  connect() {
    this.animateHero()
  }

  animateHero() {
    // Ensure the image is fully visible
    this.imageWrapTarget.classList.add("scale-100")

    // Animate the text after the image animation completes
    setTimeout(() => {
      this.textWrapTarget.classList.remove("opacity-0", "translate-y-10")
      this.textWrapTarget.classList.add("opacity-100", "translate-y-0")
    }, 500) // Delay matches the image animation duration
  }
}
