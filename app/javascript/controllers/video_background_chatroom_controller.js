import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["video"]

  connect() {
    if (this.hasVideoTarget) {
      this.videoTarget.playbackRate = 0.7;
    }
  }
}
