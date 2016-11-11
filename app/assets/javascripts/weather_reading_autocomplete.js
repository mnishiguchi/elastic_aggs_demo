// https://github.com/substack/browserify-handbook#exports
module.exports = function() {

  // Remote Source — Github
  // https://selectize.github.io/selectize.js/#demo-github
  // https://github.com/selectize/selectize.js/blob/master/examples/github.html
  $(document).on('turbolinks:load', () => {
    $('#q').selectize({
      valueField:  'station', //==> This will become a query term
      labelField:  'station_name',
      searchField: 'station_name',
      create:      false,

      render: {
        option: function(item, escape) {

          console.log("render");

          return (`
            <div>
              <h4 class="title">
                ${escape(item.reading_type)}
              </h4>
              <p>
                ${escape(item.station)}
              </p>
            </div>
          `);
        }
      },
      score: function(search) {
        var score = this.getScoreFunction(search);
        return function(item) {
          return score(item) * (1 + Math.min(item.watchers / 100, 1));
        };
      },
      load: function(query, callback) {
        if (!query.length) {
          return callback()
        };
        $.ajax({
          url: '../weather_readings/autocomplete?q=' + encodeURIComponent(query),
          type: 'GET',
          error: () => {
            callback();
          },
          success: res => {
            console.log(res)
            callback(res.weather_readings.slice(0, 10));
          }
        });
      }
    });
  });
}
