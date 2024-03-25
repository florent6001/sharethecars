import { Controller } from "@hotwired/stimulus";
import { Chart } from "chart.js/auto";

export default class extends Controller {
  static values = {
    baseKilometers: String,
    reservations: Array
  };

  connect() {
    const baseKilometers = parseInt(this.baseKilometersValue);
    const chartData = [baseKilometers];
    const labels = ['Base'];

    this.reservationsValue.forEach((reservation) => {
      chartData.push(parseInt(reservation.kilometers));
      console.log(reservation.created_at)
      labels.push(new Date(reservation.created_at).toLocaleString('fr-FR', { day: '2-digit', month: '2-digit' }).replace(/\//g, '/'));
    });


    const data = {
      labels: labels,
      datasets: [{
        label: "Evolution kilométrique",
        data: chartData,
        fill: true,
        borderColor: "rgb(75, 192, 192)",
        tension: 0.1
      }]
    };

    new Chart(this.element, {
      type: "line",
      data: data,
    });
  }
}
