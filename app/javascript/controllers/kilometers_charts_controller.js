import { Controller } from "@hotwired/stimulus"
import { Chart } from "chart.js/auto";

export default class extends Controller {
  static values = {
    baseKilometers: String,
    reservations: Array
  }

  connect() {
    const base_kilometers = parseInt(this.baseKilometersValue);
    const monthlyData = {};

    this.reservationsValue.forEach((reservation) => {
      const monthNumber = parseInt(reservation.start_date.split('-')[1]);
      const monthNames = [
        "janvier", "février", "mars", "avril", "mai", "juin", "juillet", "août", "septembre", "octobre", "novembre", "décembre"
      ];
      const monthName = monthNames[monthNumber - 1];
      if (!monthlyData[monthName]) {
        monthlyData[monthName] = [];
      }
      monthlyData[monthName].push(parseInt(reservation.kilometers));
    });

    const labels = ['Base', ...Object.keys(monthlyData)];
    const chartData = [base_kilometers];
    Object.values(monthlyData).forEach((monthData) => {
      const averageKilometers = monthData.reduce((acc, val) => acc + val, 0) / monthData.length;
      chartData.push(averageKilometers);
    });

    const data = {
      labels: labels,
      datasets: [{
        label: 'Evolution kilométrique',
        data: chartData,
        fill: true,
        borderColor: 'rgb(75, 192, 192)',
        tension: 0.1
      }]
    };

    new Chart(this.element, {
      type: 'line',
      data: data,
    });
  }
}
