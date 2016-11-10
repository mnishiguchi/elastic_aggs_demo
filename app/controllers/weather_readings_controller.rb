class WeatherReadingsController < ApplicationController

  def index
    search = WeatherReadingsSearch.new(search_params).search

    @weather_readings = search[:results]
    @active_filters   = search[:active_filters]
  end

  private def search_params
    # TODO: make a whitelist.
    params.permit!
  end
end
