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
    if filter_hash[:reading_type].present?
      "Reading type: #{filter_hash[:reading_type]}"
    end
  end

  def reading_value_text(filter_hash)
    min, max = filter_hash[:reading_value_min], filter_hash[:reading_value_max]
    if min.present? && max.present?
      "Reading value: #{min} to #{max}"
    elsif min.present?
      "Reading value: Min #{min}"
    elsif max.present?
      "Reading value: Max #{max}"
    end
  end

  # TODO
  def reading_date_text(filter_hash)
    # if filter_hash[:reading_type].present?
    #   "Reading type: #{filter_hash[:reading_type]}"
    # end
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

  def reading_year_select_tag(params, key, options={default_select: :first})
    default_select = reading_date_years.try!(options[:default_select])
    select_tag(
      key,
      options_for_select(reading_date_years, default_select),
      include_blank: false
    )
  end

  def reading_month_select_tag(params, key, options={default_select: :first})
    default_select = reading_date_months.try!(options[:default_select])
    select_tag(
      key,
      options_for_select(reading_date_months, default_select),
      include_blank: false
    )
  end

  def reading_day_select_tag(params, key, options={default_select: :first})
    default_select = reading_date_days.try!(options[:default_select])
    select_tag(
      key,
      options_for_select(reading_date_days, default_select),
      include_blank: false
    )
  end

  def reading_date_years
    WeatherReading.pluck(:reading_date).map(&:year).uniq
  end

  def reading_date_months
    (1..12).to_a
  end

  def reading_date_days
    (1..31).to_a
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
end
