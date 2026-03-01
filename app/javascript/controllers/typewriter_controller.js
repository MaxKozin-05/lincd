import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["text"]

  connect() {
    this.text = "We connect skilled construction professionals with the right opportunities."
    this.index = 0
    this.speed = 50
    this.hasStarted = false

    this.setupIntersectionObserver()
  }

  setupIntersectionObserver() {
    this.observer = new IntersectionObserver((entries) => {
      entries.forEach(entry => {
        if (entry.isIntersecting && !this.hasStarted) {
          this.hasStarted = true
          this.startTyping()
          // Stop observing after it starts
          this.observer.unobserve(this.element)
        }
      })
    }, {
      threshold: 0.5, // Trigger when 50% of element is visible
      rootMargin: '0px 0px -100px 0px' // Start slightly before element is fully visible
    })

    this.observer.observe(this.element)
  }

  startTyping() {
    if (this.index < this.text.length) {
      this.textTarget.textContent += this.text.charAt(this.index)
      this.index++
      setTimeout(() => this.startTyping(), this.speed)
    }
  }

  disconnect() {
    // Clean up observer
    if (this.observer) {
      this.observer.disconnect()
    }
  }
}
