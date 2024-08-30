class LoadingsController < ApplicationController
  # Fetch filter options for the frontend
  def filter_options
    trucks = Loading.distinct.pluck(:truck)
    loaded_msas = Loading.select("DISTINCT TO_CHAR(loaded_msa, 'YYYY-MM-DD') AS loaded_msa").map { |loading| loading.loaded_msa }
    msa_arvd_or_enroute = Loading.select("DISTINCT TO_CHAR(msa_arvd_or_enroute, 'YYYY-MM-DD') AS msa_arvd_or_enroute").map { |loading| loading.msa_arvd_or_enroute }
    disp_msa_date = Loading.select("DISTINCT TO_CHAR(disp_msa_date, 'YYYY-MM-DD') AS disp_msa_date").map { |loading| loading.disp_msa_date }
    current_truck_stats = Loading.distinct.pluck(:current_truck_stat)
    final_destinations = Loading.distinct.pluck(:final_destination)
    customers = Loading.distinct.pluck(:customer)
    allocation_statuses = Loading.distinct.pluck(:allocation_status)
    allocated_clients = Loading.distinct.pluck(:allocated_clients)

    render json: {
      trucks: trucks,
      loaded_msa: loaded_msas.map { |date| date.strftime('%Y-%m-%d') if date.present? },
      msa_arvd_or_enroute: msa_arvd_or_enroute.map { |date| date.strftime('%Y-%m-%d') if date.present? },
      disp_msa_date: disp_msa_date.map { |date| date.strftime('%Y-%m-%d') if date.present? },
      current_truck_stats: current_truck_stats,
      final_destinations: final_destinations,
      customers: customers,
      allocation_statuses: allocation_statuses,
      allocated_clients: allocated_clients,

    }
  end

  # CRUD actions for loadings
  def index
    loadings = Loading.all
  
    if params[:truck].present?
      selected_trucks = params[:truck].split(',')
      loadings = loadings.where(truck: selected_trucks)
    end
  
    if params[:msa_arvd_or_enroute].present?
      msa_arvd_or_enroutes = params[:msa_arvd_or_enroute].split(',')
      loadings = loadings.where(msa_arvd_or_enroute: msa_arvd_or_enroutes)
    end
  
    if params[:loaded_msa].present?
      loaded_msas = params[:loaded_msa].split(',')
      loadings = loadings.where(loaded_msa: loaded_msas)
    end
  
    if params[:current_truck_stat].present?
      current_truck_stats = params[:current_truck_stat].split(',')
      loadings = loadings.where(current_truck_stat: current_truck_stats)
    end
  
    if params[:final_destination].present?
      final_destinations = params[:final_destination].split(',')
      loadings = loadings.where(final_destination: final_destinations)
    end
  
    if params[:customer].present?
      customers = params[:customer].split(',')
      loadings = loadings.where(customer: customers)
    end
  
    if params[:allocation_status].present?
      allocation_statuses = params[:allocation_status].split(',')
      loadings = loadings.where(allocation_status: allocation_statuses)
    end
  
    if params[:disp_msa_date].present?
      disp_msa_dates = params[:disp_msa_date].split(',')
      loadings = loadings.where(disp_msa_date: disp_msa_dates)
    end

    if params[:allocated_clients].present?
      allocated_clientses = params[:allocated_client].split(',')
      loadings = loadings.where(allocated_client: allocated_clientses)
    end
  
    loadings = loadings.order(:msa_arvd_or_enroute, :truck) # Sorting by msa_arvd_or_enroute and then truck
  
    render json: loadings
  end  

  def show
    loading = Loading.find_by(id: params[:id])
    if loading
      render json: loading
    else
      render json: { error: "Loading detail not found" }, status: :not_found
    end
  end

  def create
    # Clear all existing loadings
    Loading.delete_all
    loading = Loading.create!(loading_params)
    render json: loading, status: :created
  end

  def update
    loading = Loading.find_by(id: params[:id])
    if loading
      loading.update(loading_params)
      render json: loading
    else
      render json: { error: "Loading detail not found" }, status: :not_found
    end
  end

  def destroy
    loading = Loading.find_by(id: params[:id])
    if loading
      loading.destroy
      head :no_content
    else
      render json: { error: "Loading detail not found" }, status: :not_found
    end
  end

  def truck_turnaround
    turnaround_data = []

    trucks = Loading.pluck(:truck).uniq

    trucks.each do |truck|
      loadings = Loading.where(truck: truck).order(:disp_msa_date)

      loadings.each_with_index do |loading, index|
        next_loading = loadings[index + 1]
        next unless next_loading

        turnaround_time = (next_loading.msa_arvd_or_enroute - loading.disp_msa_date).to_i

        turnaround_data << {
          truck: truck,
          route_name: loading.final_destination, # Ensure this attribute exists
          turnaround_time: turnaround_time
        }
      end
    end

    render json: { data: turnaround_data }
  end

  private

  def loading_params
    params.permit(:truck, :trailer, :diff, :truckconfig, :truck_reg, :msa_arvd_or_enroute, :customer, :loaded_msa, :disp_msa_date, :days_in_msa, :final_destination, :date_offloaded, :current_truck_stat, :allocation_status, :allocated_clients, :workshop_comments, :proj_rev)
  end
end
