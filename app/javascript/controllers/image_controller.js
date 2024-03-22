import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="image"
export default class extends Controller {
  connect() {

      const hoverTrigger = document.getElementById('hover-trigger');
      const phare = document.getElementById('phare');

      if (hoverTrigger && carImage) {
        hoverTrigger.addEventListener('mouseover', () => {
          phare.classList.remove('d-none');
        });

        hoverTrigger.addEventListener('mouseout', () => {
          phare.classList.add('d-none');
        });
      }
  }
}
