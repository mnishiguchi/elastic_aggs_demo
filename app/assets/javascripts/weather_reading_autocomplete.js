$(document).on('turbolinks:load', function(){

  // Set up autocomplete
  // http://twitter.github.io/typeahead.js/examples/
  var weather_readings_autocomplete = new Bloodhound({
    datumTokenizer: Bloodhound.tokenizers.whitespace,
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    prefetch: '../weather_readings/autocomplete.json'
  });

  $('#q.typeahead').typeahead({
      highlight: true,
      minLength: 1,
      limit: 30
    }, {
      name:  'weather_readings_autocomplete',
      source: weather_readings_autocomplete
  });

  // Trigger search when a suggestion is selected.
  // http://stackoverflow.com/questions/9496314/bootstrap-typeahead-js-add-a-listener-on-select-event
  $('#q.typeahead').on('typeahead:selected', function(event){
    console.log("Clicked: ", event.target.value);
    $('button[type="submit"]').click();
  });
});
