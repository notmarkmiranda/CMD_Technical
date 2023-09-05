class PatientRecord
  attr_reader :first_name, :last_name, :dob, :member_id, :effective_date, :expiry_date, :phone_number

  def initialize(attributes)
    @first_name = attributes[:first_name]
    @last_name = attributes[:last_name]
    @dob = Date.parse(attributes[:dob])
    @member_id = attributes[:member_id]
    @effective_date = Date.parse(attributes[:effective_date])
    @expiry_date = Date.parse(attributes[:expiry_date])
    @phone_number = attributes[:phone_number]
  end
end