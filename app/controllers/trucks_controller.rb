class TrucksController < ApplicationController
  # Fetch filter options for the frontend
  def filter_options
    loaded_statuses = Truck.distinct.pluck(:loaded_status)
    trucks = Truck.distinct.pluck(:truck)
    regions = Truck.distinct.pluck(:region)
    statuses = Truck.distinct.pluck(:status)
    customers = Truck.distinct.pluck(:customer)
    routes = Truck.distinct.pluck(:route_name)
    modes = Truck.distinct.pluck(:mode)
    locations = Truck.distinct.pluck(:location)
    status_dates = Truck.distinct.pluck(:status_date)
    remarkses = Truck.distinct.pluck(:remarks)

    render json: {
      loaded_statuses: loaded_statuses,
      trucks: trucks,
      regions: regions,
      statuses: statuses,
      customers: customers,
      routes: routes,
      modes: modes,
      locations: locations,
      status_dates: status_dates
    }
  end

  # Fetch chart data based on truck and date range
  def charts
    truck = params[:truck]
    start_date = params[:startDate]
    end_date = params[:endDate]
    location = params[:location]
  
    # Filter records based on the parameters
    records = Truck.where(truck: truck)
                   .where("status_date >= ? AND status_date <= ?", start_date, end_date)
                   .order(:status_date)
  
    # Process chart data
    dates_and_distances = records.pluck(:status_date, :distance_covered)
    loaded_dates_and_routes = records.pluck(:date_loaded, :route_name).uniq

    dates = dates_and_distances.map(&:first)
    distances = dates_and_distances.map(&:last)
    loaded_dates = loaded_dates_and_routes.map(&:first)
    route_names = loaded_dates_and_routes.map(&:last)

    render json: {
      dates: dates,
      distances: distances,
      loaded_dates: loaded_dates,
      route_names: route_names
    }
  end

  # CRUD actions for trucks
  def index
    trucks = Truck.all.order(status_date: :desc)

    if params[:loaded_status].present?
      loaded_statuses = params[:loaded_status].split(',')
      trucks = trucks.where(loaded_status: loaded_statuses)
    end

    if params[:region].present?
      regions = params[:region].split(',')
      trucks = trucks.where(region: regions)
    end

    if params[:location].present?
      locations = params[:location].split(',')
      trucks = trucks.where(location: locations)
    end

    if params[:status_date].present?
      status_dates = params[:status_date].split(',')
      trucks = trucks.where(status_date: status_dates)
    end

    if params[:truck].present?
      selected_trucks = params[:truck].split(',')
      trucks = trucks.where(truck: selected_trucks)
    end

    render json: trucks
  end

  def show
    truck = Truck.find_by(id: params[:id])
    if truck
      render json: truck
    else
      render json: { error: "Container detail not found" }, status: :not_found
    end
  end

  def create
    truck = Truck.create!(truck_params)
    render json: truck, status: :created
  end

  def update
    truck = Truck.find_by(id: params[:id])
    if truck
      truck.update(truck_params)
      render json: truck
    else
      render json: { error: "Container detail not found" }, status: :not_found
    end
  end

  def destroy
    truck = Truck.find_by(id: params[:id])
    if truck
      truck.destroy
      head :no_content
    else
      render json: { error: "Container detail not found" }, status: :not_found
    end
  end

  private

  def truck_params
    params.permit(:truck, :customer, :product, :depot, :route_name, :date_loaded, :mode, :loaded_status, :location, :status_date, :status_time, :status, :remarks, :distance_covered, :region, :country)
  end
end
