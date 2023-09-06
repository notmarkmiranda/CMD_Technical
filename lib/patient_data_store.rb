class PatientDataStore
  attr_reader :records

  def initialize
    @records = {valid: [], invalid: []}
  end

  def add(record)
    record.save if record.valid?.nil?

    if record.valid?
      records[:valid] << record
    elsif record.invalid?
      records[:invalid] << record
    end

    record
  end

  def valid_records
    records[:valid]
  end

  def invalid_records
    records[:invalid]
  end

  def generate_csv
    {
      records: valid_records.map(&:to_csv),
      errors: {summary: generate_summary}
    }
  end

  private

  def generate_summary
    <<~EOS
      #{valid_records.count} valid record(s)
      #{invalid_records.count} invalid record(s).
      Here are the list of errors from the invalid records:\n#{invalid_records.flat_map(&:errors).join("\n")}
    EOS
  end
end
