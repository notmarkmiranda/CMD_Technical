require "csv"

class FileHandler
  def self.import(file)
    results = []
    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      results << {
        first_name: row[:first_name],
        last_name: row[:last_name],
        dob: row[:dob],
        member_id: row[:member_id],
        effective_date: row[:effective_date],
        expiry_date: row[:expiry_date],
        phone_number: row[:phone_number]
      }
    end

    results
  end

  def self.export(datastore_output)
    headers = ["first_name", "last_name", "dob", "member_id", "effective_date", "expiry_date", "phone_number"]
    CSV.open("records.csv", "w") do |csv|
      csv << headers
      datastore_output[:records].each do |record|
        csv << record.split(",")
      end
    end

    File.write("output.txt", datastore_output[:summary])
  end
end
