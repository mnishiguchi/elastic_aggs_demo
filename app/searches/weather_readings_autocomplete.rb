class WeatherReadingsAutocomplete < WeatherReadingsSearch

  def json
    results = search_model.search(query, search_constraints)
    results = results.map(&:to_h).map do |result|
      result.slice("station", "reading_type", "station_name")
    end.flatten.uniq

    { weather_readings: results }
  end

  private def search_constraints
    {
      match:        :word_start,
      misspellings: { below: 5 },
      load:  false,
      where: where,
      order: order,
    }
  end
end
