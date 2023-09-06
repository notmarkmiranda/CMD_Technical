require "./spec/spec_helper"
require "./lib/patient_record"
require "date"

RSpec.describe PatientRecord do
  let(:attributes) do
    {
      first_name: "Mark",
      last_name: "Miranda",
      dob: "09/13/2023",
      member_id: "asdf1234",
      effective_date: "09/13/2023",
      expiry_date: "09/13/2024",
      phone_number: "3038476953"
    }
  end

  it "instantiates a record with all of the attributes" do
    patient_record = described_class.new(attributes)

    expect(patient_record.first_name).to eq("Mark")
    expect(patient_record.last_name).to eq("Miranda")
    expect(patient_record.dob).to eq(Date.new(2023, 9, 13))
    expect(patient_record.member_id).to eq("asdf1234")
    expect(patient_record.effective_date).to eq(Date.new(2023, 9, 13))
    expect(patient_record.expiry_date).to eq(Date.new(2024, 9, 13))
    expect(patient_record.phone_number).to eq("3038476953")
  end

  it "returns true when valid_attributes exist" do
    patient_record = described_class.new(attributes)

    expect(patient_record.save).to eq(true)
  end

  it "returns false when missing a required attribute" do
    patient_record = described_class.new(attributes.merge(first_name: ""))

    expect(patient_record.save).to eq(false)
  end

  it "returns false when invalid phone_number format" do
    patient_record = described_class.new(attributes.merge(phone_number: "303847695"))

    expect(patient_record.save).to eq(false)
    expect(patient_record.errors).to eq(["phone_number is improperly formatted"])
  end

  describe "valid attribute" do
    it "returns nil by default" do
      patient_record = described_class.new(attributes)
      
      expect(patient_record.valid?).to eq(nil)
      expect(patient_record.valid?).not_to eq(false)
    end

    it "returns false after a record has been saved with invalid attributes" do
      patient_record = described_class.new(attributes.merge(first_name: ""))

      patient_record.save
      expect(patient_record.valid?).to eq(false)
      expect(patient_record.valid?).not_to eq(nil)
    end

    it "returns true after a record has been saved with valid attributes" do
      patient_record = described_class.new(attributes)

      patient_record.save
      expect(patient_record.valid?).to eq(true)
    end
  end

  describe "date attributes" do
    it "can assign date attributes when passed in as MM/DD/YYYY" do
      patient_record = described_class.new(attributes.merge(dob: "12/31/2010"))

      expect(patient_record.dob).to eq(Date.new(2010, 12, 31))
    end

    it "can assign date attributes when passed in as m/m/yy" do
      patient_record = described_class.new(attributes.merge(dob: "6/6/99"))

      expect(patient_record.dob).to eq(Date.new(1999, 6, 6))
    end

    it "can assign date attributes when passed in as yyyy-mm-dd" do
      patient_record = described_class.new(attributes.merge(dob: "1988-02-13"))

      expect(patient_record.dob).to eq(Date.new(1988, 2, 13))
    end

    it "can assign date attributes when passed in as 1-31-88" do
      patient_record = described_class.new(attributes.merge(dob: "1-31-88"))

      expect(patient_record.dob).to eq(Date.new(1988, 1, 31))
    end
  end

  describe "#to_csv" do
    it "returns attributes in csv format" do
      patient_record = described_class.new(attributes)      

      expect(patient_record.to_csv).to eq("Mark,Miranda,2023-09-13,asdf1234,2023-09-13,2024-09-13,3038476953")
    end

    it "when there are some nil attributes" do
      patient_record = described_class.new(attributes.merge(expiry_date: nil))
      
      expect(patient_record.to_csv).to eq("Mark,Miranda,2023-09-13,asdf1234,2023-09-13,,3038476953")
    end
  end
end
