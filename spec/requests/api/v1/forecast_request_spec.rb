require 'rails_helper'

RSpec.describe "Forecast request spec", type: :request do
  describe "#index", :vcr do
    before(:each) do
      time = Time.local(2024, 9, 16, 4, 0, 0)
      Timecop.travel(time)
    
      loveland = SkiArea.create!(name: "Loveland", location_id: "ChIJDW4E2OtRaocR6Ny-eVsZRyY" )
      winter_park = SkiArea.create!(name: "Winter Park", location_id: "ChIJy0LIeaDKa4cRW2sSTH03-bU" )
      arapahoe_basin = SkiArea.create!(name: "Arapahoe Basin", location_id: "ChIJWd2U7rRQaocRllxVIFIp5Ts" )
      keystone = SkiArea.create!(name: "Keystone", location_id: "ChIJW_aKIwJaaocRr6sP37eZJ_M" )
      breckenridge = SkiArea.create!(name: "Breckenridge", location_id: "ChIJ5SL_Vd71aocRHD59U1wlA8s" )
      copper = SkiArea.create!(name: "Copper", location_id: "ChIJe2Rv9PdfaocR-3_TarNZh2M")
      vail = SkiArea.create!(name: "Vail", location_id: "ChIJ29swxmBwaocRoq1FSy3Pwqc" )
      beaver_creek = SkiArea.create!(name: "Beaver Creek", location_id: "ChIJLUeXah54aocRLCubAYD6EBI" )
      cooper = SkiArea.create!(name: "Cooper", location_id: "ChIJYbUu1wOPaocRTDe7TMTsUhE")
      monarch = SkiArea.create!(name: "Monarch", location_id: "ChIJtzbUKLpCFYcRGpheZl7SdZw")
    end

      it "returns a duration forecast with the specfied attributes" do
        get "/api/v1/forecast?direction=west"
        forecast = JSON.parse(response.body, symbolize_names: true)
        attribute_keys = [:date, :direction, :duration_info]
        resort_keys = [:Loveland, :"Winter Park", :"Arapahoe Basin", :Keystone, :Breckenridge, :Copper, :Vail, :"Beaver Creek", :Cooper, :Monarch]
      
        expect(response).to be_successful
        expect(forecast).to be_a(Hash)
        expect(forecast).to have_key(:data)
        expect(forecast[:data][:attributes].keys).to eq(attribute_keys)
        expect(forecast[:data][:attributes][:direction]).to eq("west")
        expect(forecast[:data][:attributes][:duration_info].keys).to eq(resort_keys)
    end
  end
end