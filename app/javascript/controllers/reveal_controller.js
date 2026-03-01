import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["item"]

  connect() {
    // baseline (in case of server-render flash)
    gsap.set(this.itemTargets, { autoAlpha: 0, y: 12 })

    gsap.to(this.itemTargets, {
      autoAlpha: 1, y: 0, duration: 0.5, ease: "power2.out", stagger: 0.08,
      scrollTrigger: this.hasScrollTrigger() ? undefined : null
    })

    // Fallback reveal without ScrollTrigger (if you haven’t added it yet)
    // If/when you add ScrollTrigger, I’ll switch this to use it.
  }

  hasScrollTrigger() {
    // If you plan to add ScrollTrigger later, just change this to true and wire it in.
    return false
  }
}
