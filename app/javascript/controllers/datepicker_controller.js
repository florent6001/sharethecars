import { Controller } from "@hotwired/stimulus"
import flatpickr from 'flatpickr';
import rangePlugin from 'flatpickr/dist/plugins/rangePlugin';

export default class extends Controller {
  static targets = ["container"]
  static values = {
    dates: Array
  }

  connect() {
    const disabledDates = this.datesValue.map(date => ({
      from: date.start_date,
      to: date.end_date
    }));
    console.log(this.datesValue)
    console.log(disabledDates)

    const pickers = document.querySelectorAll('.flatpickr-calendar')
    pickers.forEach(picker => {
      picker.remove()
    })

    flatpickr(this.containerTarget, {
      minDate: 'today',
      mode: "range",
      inline: true,
      disable: disabledDates,
      "plugins": [new rangePlugin({ input: "#end_date" })]
    })
  }

  // disconnect() {
  //   alert('disconnected')
  // }

  reset() {
    this.containerTarget._flatpickr.clear()
  }
}
