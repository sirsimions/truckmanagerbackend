class UploadsController < ApplicationController
  require 'roo'

  def create
    file = params[:file]
    upload_type = params[:upload_type]

    if file.present? && upload_type.present?
      spreadsheet = Roo::Spreadsheet.open(file.path)
      header = spreadsheet.row(1)

      if upload_type == 'truck'
        process_truck_data(spreadsheet, header)
      elsif upload_type == 'loadings'
        process_loadings_data(spreadsheet, header)
      else
        render json: { message: 'Invalid upload type.' }, status: :bad_request
        return
      end

      render json: { message: 'File uploaded and data processed successfully.' }, status: :ok
    else
      render json: { message: 'No file uploaded or upload type not specified.' }, status: :bad_request
    end
  end

  private

  def process_truck_data(spreadsheet, header)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      # Create a new Truck record for each row
      Truck.create!(
        truck: row["Truck"],
        customer: row["Customer"],
        product: row["Product"],
        depot: row["Depot"],
        route_name: row["Route Name"],
        date_loaded: row["Date Loaded"],
        mode: row["Mode"],
        loaded_status: row["Loaded status"],
        location: row["Location"],
        status_date: row["Status Date"],
        status_time: row["Status Time"],
        status: row["Status"],
        remarks: row["Remarks"],
        distance_covered: row["Distance covered"],
        region: row["Region"],
        country: row["Country"]
      )
    end
  end
  

  def process_truck_data(spreadsheet, header)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
  
      # Create a new Truck record for each row
      Truck.create!(
        truck: row["Truck"],
        customer: row["Customer"],
        product: row["Product"],
        depot: row["Depot"],
        route_name: row["Route Name"],
        date_loaded: row["Date Loaded"],
        mode: row["Mode"],
        loaded_status: row["Loaded status"],
        location: row["Location"],
        status_date: row["Status Date"],
        status_time: row["Status Time"],
        status: row["Status"],
        remarks: row["Remarks"],
        distance_covered: row["Distance covered"],
        region: row["Region"],
        country: row["Country"]
      )
    end
  end
  
  def process_loadings_data(spreadsheet, header)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      # Create a new Loading record for each row
      Loading.create!(
        truck: row["Truck"],
        trailer: row["Trailer"],
        truckconfig: row["Truckconfig"],
        loaded_msa: row["Loaded MSA"],
        current_truck_stat: row["Current Truck Stat"],
        msa_arvd_or_enroute: row["MSA Arvd/Enroute"],
        final_destination: row["Final Destination"],
        customer: row["Customer"],
        allocation_status: row["Allocation status"],
        allocated_clients: row["Allocated Clients"],
        disp_msa_date: row["Disp MSA Date"],
        days_in_msa: row["Days in MSA"],
        created_at: DateTime.now  # Use the current timestamp as the created_at value
      )
    end
  end
  
end
