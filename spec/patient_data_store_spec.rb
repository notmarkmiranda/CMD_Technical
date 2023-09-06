require "./spec/spec_helper"
require "./lib/patient_data_store"
require "./lib/patient_record"

RSpec.describe PatientDataStore do
  let(:data_store) { described_class.new }

  describe "storing patient data records" do
    it "has no records on instantiation" do
      expect(data_store.valid_records).to be_empty
      expect(data_store.invalid_records).to be_empty
    end

    it "can add records" do
      patient_record = double("patient record", valid?: true, invalid?: false)

      expect(data_store.add(patient_record)).to eq(patient_record)
      expect(data_store.valid_records).not_to be_empty
    end
  end

  describe "#generate_csv" do
    let(:valid_records) { [instance_double("patient_record", valid?: true, invalid?: false), instance_double("patient_record", valid?: true, invalid?: false)] }
    let(:invalid_records) { [instance_double("patient_record", valid?: false, invalid?: true)] }
    let(:all_records) { valid_records + invalid_records }

    describe "valid records" do
      it "can return valid records" do
        all_records.each do |rec|
          data_store.add(rec)
        end

        expect(data_store.valid_records.count).to eq(2)
      end
    end

    describe "invalid records" do
      it "can return invalid records" do
        all_records.each do |rec|
          data_store.add(rec)
        end

        expect(data_store.invalid_records.count).to eq(1)
      end
    end

    describe "csv generation" do
      let(:store) { described_class.new }

      before do
        first_record = PatientRecord.new({
          last_name: "Miranda",
          first_name: "Mark",
          dob: "09/13/2023",
          member_id: "asdf1234",
          effective_date: "09/13/2023",
          expiry_date: "09/13/2024",
          phone_number: "3038476953"
        })

        second_record = PatientRecord.new({
          last_name: "Miranda",
          first_name: "Salem",
          dob: "03/01/2020",
          member_id: "asdf1235",
          effective_date: "09/13/2023",
          expiry_date: "09/13/2024",
          phone_number: "3038476954"
        })

        valid_records = [first_record, second_record]
        invalid_record = [PatientRecord.new({})]
        all_records = valid_records + invalid_record

        all_records.each do |record|
          store.add(record)
        end
      end

      it "generates a csv of valid records & data for output text" do
        expected_return = {
          records: [
            "Mark,Miranda,2023-09-13,asdf1234,2023-09-13,2024-09-13,3038476953",
            "Salem,Miranda,2020-03-01,asdf1235,2023-09-13,2024-09-13,3038476954"
          ],
          summary:
            "2 valid record(s)\n1 invalid record(s).\nHere are the list of errors from the invalid records:\nfirst_name cannot be blank\nlast_name cannot be blank\ndob cannot be blank\nmember_id cannot be blank\neffective_date cannot be blank\nphone_number is improperly formatted\n"
        }

        expect(store.generate_csv).to eq(expected_return)
      end
    end
  end
end
