require "./spec/spec_helper"
require "./lib/patient_record"
require "date"

RSpec.describe PatientRecord do 
  it "instantiates a record with all of the attributes" do
    attributes = {
      last_name: "Miranda",
      first_name: "Mark",
      dob: "5/9/2023",
      member_id: "asdf1234",
      effective_date: "5/9/2023",
      expiry_date: "5/9/2024",
      phone_number: "3038476953"
    }
    
    patient_record = described_class.new(attributes)
    
    expect(patient_record.first_name).to eq("Mark")
    expect(patient_record.last_name).to eq("Miranda")
    expect(patient_record.dob).to eq(Date.new(2023, 9, 05))
    expect(patient_record.member_id).to eq("asdf1234")
    expect(patient_record.effective_date).to eq(Date.new(2023, 9, 05))
    expect(patient_record.expiry_date).to eq(Date.new(2024, 9, 05))
    expect(patient_record.phone_number).to eq("3038476953")
  end
end