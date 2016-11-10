module WeatherReadingsHelper

  def weather_readings_title
    total_count_text(@weather_readings)
  end


  # ---
  # Search meta
  # ---


  def total_count_text(results)
    "#{pluralize(results.try!(:total_count), "record")} found"
  end

  def q_text(filter_hash)
    if filter_hash["q"]&.present?
      filter_hash["q"]
    end
  end

  def reading_type_text(filter_hash)
    if filter_hash["reading_type"]&.present?
      filter_hash["reading_type"]
    end
  end

  def reading_value_text(filter_hash)
    min, max = filter_hash[:reading_value_min], filter_hash[:reading_value_max]
    if min.present? && max.present?
      "Reading value: #{min} to #{max}"
    elsif min.present?
      "Reading value: Min $#{min}"
    elsif max.present?
      "Reading value: Max $#{max}"
    end
  end

  private def sort_text(filter_hash)

    # TODO

  end

  private def reading_type_text(filter_hash)
    "Reading type: #{filter_hash[:reading_type]}" if filter_hash[:reading_type].present?
  end


  # ---
  # Sorting
  # ---


  def sort_attribute_select_tag(params)
    options = {
      "reading_date"  => "reading_date",
      "reading_type"  => "reading_type",
      "reading_value" => "reading_value",
      "source_flag"   => "source_flag",
      "station_name"  => "station_name",
      "station"       => "station",
    }
    select_tag(
      "sort_attribute",
      options_for_select(options, params[:sort_attribute]),
      include_blank: false
    )
  end

  def sort_order_select_tag(params)
    options = {
      "Ascending"  => "asc",
      "Descending" => "desc"
    }
    select_tag(
      "sort_order",
      options_for_select(options, params[:sort_order]),
      include_blank: false
    )
  end


  # ---
  # Filtering
  # ---


  def reading_type_select_tag(params)
    reading_types = WeatherReading.distinct(:reading_type).pluck(:reading_type)
    select_tag(
      "reading_type",
      options_for_select(reading_types, params[:reading_type]),
      include_blank: true
    )
  end

  def bathroom_count_select_tag(params)
    select_tag(
      "bathroom_count",
      options_for_select(%w(1+ 2+ 3+), params[:bathroom_count]),
      include_blank: true
    )
  end
end
