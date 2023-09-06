require "./spec/spec_helper"
require "./lib/file_handler"

RSpec.describe FileHandler do
  let(:input_file) { "./spec/fixtures/input.csv" }

  describe "#import" do
    it "can import a csv file" do
      expect(described_class.import(input_file).count).to eq(14)
    end
  end

  describe "#export" do
    it "exports 2 files" do
      csv_double = double("csv_double")
      file_double = double("file_double")

      generate_csv_from_datastore = {
        records: [
          "Mark,Miranda,2023-09-13,asdf1234,2023-09-13,2024-09-13,3038476953",
          "Salem,Miranda,2020-03-01,asdf1235,2023-09-13,2024-09-13,3038476954"
        ],
        summary: "2 valid record(s)\n1 invalid record(s).\nHere are the list of errors from the invalid records:\nfirst_name cannot be blank\nlast_name cannot be blank\ndob cannot be blank\nmember_id cannot be blank\neffective_date cannot be blank\nphone_number is improperly formatted\n"
      }

      # CSV.open("myfile.csv", "w") do |csv|
      #   csv << ["row", "of", "CSV", "data"]
      #   csv << ["another", "row"]
      #   # ...
      # end
      
      expect(CSV).to receive(:open).with("records.csv", "w").and_yield(csv_double)
      expect(csv_double).to receive(:<<).exactly(3).times
      expect(File).to receive(:open).with("output.txt", "w").and_yield(file_double)
      expect(file_double).to receive(:write).with(generate_csv_from_datastore[:summary])

      described_class.export(generate_csv_from_datastore)
    end
  end
end