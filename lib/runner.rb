require 'csv'
require "./lib/file_handler"
require "./lib/patient_record"
require "./lib/patient_data_store"

filename = ARGV[0]
data_attributes = FileHandler.import(filename)

patient_records = data_attributes.map do |attrs|
  PatientRecord.new(attrs)
end

data_store = PatientDataStore.new
patient_records.each do |record|
  data_store.add(record)
end

FileHandler.export(data_store.generate_csv)

puts "output.txt & records.csv have been generated"
puts "use `cat output.txt` or `cat records.csv` to view the files"