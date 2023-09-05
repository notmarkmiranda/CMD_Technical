require "./lib/patient_record_validator"

class PatientRecord
  attr_reader :first_name, :last_name, :dob, :member_id, :effective_date, :expiry_date, :phone_number
  include PatientRecordValidator

  def initialize(attributes)
    @first_name = attributes[:first_name]
    @last_name = attributes[:last_name]
    @dob = assign_date_attribute(attributes[:dob])
    @member_id = attributes[:member_id]
    @effective_date = assign_date_attribute(attributes[:effective_date])
    @expiry_date = assign_date_attribute(attributes[:expiry_date])
    @phone_number = attributes[:phone_number]
  end
end
