# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

# to be able to do Time.now.to_s(:db_no_tz)
custom_date_time_formats = {
  :no_tz => '%Y-%m-%d %H:%M:%S',
  :no_tz_no_sec => '%Y-%m-%d %H:%M',
  :date_no_time => '%Y-%m-%d'
}

Date::DATE_FORMATS.merge!(custom_date_time_formats)
Time::DATE_FORMATS.merge!(custom_date_time_formats)


