$(document).on('turbolinks:load', function() {
  var chart = AmCharts.makeChart("chartdiv", {
    type: "serial",
    dataDateFormat: "YYYY-MM-DD",
    dataProvider: chartData,

    addClassNames: true,
    startDuration: 1,
    color: "#000000",
    marginLeft: 0,

    categoryField: "date",
    categoryAxis: {
      parseDates: true,
      minPeriod: "DD",
      autoGridCount: false,
      gridCount: 50,
      gridAlpha: 0.1,
      gridColor: "#000000",
      axisColor: "#555555",
      dateFormats: [{
          period: 'DD',
          format: 'DD'
      }, {
          period: 'WW',
          format: 'MMM DD'
      }, {
          period: 'MM',
          format: 'MMM'
      }, {
          period: 'YYYY',
          format: 'YYYY'
      }]
    },

    valueAxes: [{
      id: "a1",
      title: "distance",
      gridAlpha: 0,
      axisAlpha: 0
    },{
      id: "a2",
      position: "right",
      gridAlpha: 0,
      axisAlpha: 0,
      labelsEnabled: false
    }],
    graphs: [{
      id: "g1",
      valueField:  "distance",
      title:  "distance",
      type:  "column",
      fillAlphas:  0.9,
      valueAxis:  "a1",
      balloonText:  "[[value]] miles",
      legendValueText:  "[[value]] mi",
      legendPeriodValueText:  "total: [[value.sum]] mi",
      lineColor:  "#263138",
      alphaField:  "alpha",
    },{
      id: "g2",
      valueField: "latitude",
      classNameField: "bulletClass",
      title: "latitude/city",
      type: "line",
      valueAxis: "a2",
      lineColor: "#03a9f4",
      lineThickness: 1,
      legendValueText: "[[description]]/[[value]]",
      descriptionField: "townName",
      bullet: "round",
      bulletSizeField: "townSize",
      bulletBorderColor: "#607d8b",
      bulletBorderAlpha: 1,
      bulletBorderThickness: 2,
      bulletColor: "#03a9f4",
      labelText: "[[townName2]]",
      labelPosition: "right",
      balloonText: "latitude:[[value]]",
      showBalloon: true,
      animationPlayed: true,
    },{
      id: "g3",
      title: "duration",
      valueField: "duration",
      type: "line",
      valueAxis: "a3",
      lineColor: "#ff5755",
      balloonText: "[[value]]",
      lineThickness: 1,
      legendValueText: "[[value]]",
      bullet: "square",
      bulletBorderColor: "#ff5755",
      bulletBorderThickness: 1,
      bulletBorderAlpha: 1,
      dashLengthField: "dashLength",
      animationPlayed: true
    }],

    chartCursor: {
      zoomable: false,
      categoryBalloonDateFormat: "DD",
      cursorAlpha: 0,
      valueBalloonsEnabled: false
    },
    legend: {
      bulletType: "round",
      equalWidths: false,
      valueWidth: 120,
      useGraphSettings: true,
      color: "#000000"
    }
  });
});
