class WeatherReadingsAutocomplete < WeatherReadingsSearch

  def json
    results = search_model.search(query, search_constraints)
    results.map(&:to_h).map do |result|
      result.slice("station", "reading_type", "station_name").values
    end.flatten.uniq.to_json
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
