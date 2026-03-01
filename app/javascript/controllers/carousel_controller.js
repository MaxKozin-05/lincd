import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["container", "prevButton", "nextButton"]

  connect() {
    this.boundUpdateButtons = this.updateButtons.bind(this)
    this.containerTarget.addEventListener("scroll", this.boundUpdateButtons, { passive: true })

    if ("ResizeObserver" in window) {
      this.resizeObserver = new ResizeObserver(() => this.updateButtons())
      this.resizeObserver.observe(this.containerTarget)
    }

    this.updateButtons()
  }

  disconnect() {
    this.containerTarget.removeEventListener("scroll", this.boundUpdateButtons)

    if (this.resizeObserver) {
      this.resizeObserver.disconnect()
    }
  }

  scrollNext() {
    this.scrollBy(this.containerTarget.clientWidth)
  }

  scrollPrev() {
    this.scrollBy(-this.containerTarget.clientWidth)
  }

  scrollBy(offset) {
    this.containerTarget.scrollBy({ left: offset, behavior: "smooth" })
  }

  updateButtons() {
    const container = this.containerTarget
    const maxScrollLeft = container.scrollWidth - container.clientWidth
    const tolerance = 8

    if (this.hasPrevButtonTarget) {
      this.prevButtonTarget.disabled = container.scrollLeft <= tolerance
    }

    if (this.hasNextButtonTarget) {
      this.nextButtonTarget.disabled = container.scrollLeft >= maxScrollLeft - tolerance
    }
  }
}
