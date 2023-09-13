require 'rails_helper'

RSpec.describe "Forecast request spec", type: :request do
  describe "#index", :vcr do
    xit "returns a duration forecast with the specfied attributes" do
      loveland = SkiArea.create!(name: "Loveland", location_id: "ChIJDW4E2OtRaocR6Ny-eVsZRyY" )
      winter_park = SkiArea.create!(name: "Winter Park", location_id: "ChIJy0LIeaDKa4cRW2sSTH03-bU" )
      arapahoe_basin = SkiArea.create!(name: "Arapahoe Basin", location_id: "ChIJWd2U7rRQaocRllxVIFIp5Ts" )
      keystone = SkiArea.create!(name: "Keystone", location_id: "ChIJW_aKIwJaaocRr6sP37eZJ_M" )
      breckenridge = SkiArea.create!(name: "Breckendridge", location_id: "ChIJ5SL_Vd71aocRHD59U1wlA8s" )
      copper = SkiArea.create!(name: "Copper", location_id: "ChIJe2Rv9PdfaocR-3_TarNZh2M")
      vail = SkiArea.create!(name: "Vail", location_id: "ChIJ29swxmBwaocRoq1FSy3Pwqc" )
      beaver_creek = SkiArea.create!(name: "Beaver Creek", location_id: "ChIJLUeXah54aocRLCubAYD6EBI" )
      cooper = SkiArea.create!(name: "Cooper", location_id: "ChIJYbUu1wOPaocRTDe7TMTsUhE")
      monarch = SkiArea.create!(name: "Monarch", location_id: "ChIJtzbUKLpCFYcRGpheZl7SdZw")

      get "/api/v1/forecast?direction=west"

      forecast = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(forecast).to be_a(Hash)
      expect(forecast).to have_key(:data)
    end
  end
end