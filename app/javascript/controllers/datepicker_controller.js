import { Controller } from "@hotwired/stimulus"
import flatpickr from 'flatpickr';
import rangePlugin from 'flatpickr/dist/plugins/rangePlugin';

export default class extends Controller {
  static values = {
    dates: Array
  }

  connect() {
    const disabledDates = this.datesValue.map(date => ({
      from: date.start_date,
      to: date.end_date
    }));

    console.log(this.datesValue)
    flatpickr(this.element, {
      minDate: 'today',
      mode: "range",
      inline: true,
      disable: disabledDates,
      allowInput: false,
      "plugins": [new rangePlugin({ input: "#end_date"})]
    })
  }
}
