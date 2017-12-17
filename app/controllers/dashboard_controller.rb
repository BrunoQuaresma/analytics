class DashboardController < ApplicationController
  def index
    return if params[:json_path].nil?

    json_url = "http://#{params[:json_path]}"
    response = HTTParty.get(json_url, format: :plain)

    @json_data = JSON.parse response, symbolize_names: true
    @json_data_grouped = Hash[ @json_data.group_by_day { |u| u[:created_at] }.map { |k, v| [k, v.size] } ]
    @json_data_keys = @json_data[0].keys
  end
end
