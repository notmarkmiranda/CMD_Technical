class PatientRecord
  attr_reader :first_name, :last_name, :dob, :member_id, :effective_date, :expiry_date, :phone_number
  ATTRIBUTES = {
    presence: [
      :first_name,
      :last_name,
      :dob,
      :member_id,
      :effective_date
    ],
    e164: [
      :phone_number
    ]
  }

  E164_VALIDATION = /^(?:\+?\d{1}\s*-?)?\(?(?:\d{3})?\)?[- ]?\d{3}[- ]?\d{4}$/
  DATE_FORMATS = {
    /(0[1-9]|1[1,2])\/(0[1-9]|[12][0-9]|3[01])\/(19|20)\d{2}/ => "%m/%d/%Y",
    /(0?[1-9]|1[012])\/(0?[1-9]|[12][0-9]|3[01])\/\d{2}/ => "%m/%d/%y",
    /(19|20)\d{2}-(0[1-9]|1[1,2])-(0[1-9]|[12][0-9]|3[01])/ => "%Y-%m-%d",
    /(0?[1-9]|1[012])-(0?[1-9]|[12][0-9]|3[01])-\d{2}/ => "%m-%d-%y"
  }

  def initialize(attributes)
    @first_name = attributes[:first_name]                       # required
    @last_name = attributes[:last_name]                       # required
    @dob = assign_date_attribute(attributes[:dob])            # required
    @member_id = attributes[:member_id]                       # required
    @effective_date = assign_date_attribute(attributes[:effective_date]) # required
    @expiry_date = assign_date_attribute(attributes[:expiry_date])
    @phone_number = attributes[:phone_number]
  end

  def save
    @errors = []
    check_attributes
    
    return @errors.empty?
  end

  private

  def check_attributes
    check_presence_attributes
    check_phone_number_attribute
  end

  def check_presence_attributes
    ATTRIBUTES[:presence].each do |attr|
      attribute = send(attr)
      absence = attribute.respond_to?(:empty?) ? attribute.strip.empty? : !attribute
      @errors << "#{attr} cannot be blank" if absence
    end
  end

  def check_phone_number_attribute
    ATTRIBUTES[:e164].each do |attr|
      attribute = send(attr)
      valid_format = E164_VALIDATION.match?(attribute)
      @errors << "#{attr} is improperly formatted" unless valid_format
    end
  end

  def assign_date_attribute(date_string)
    format = DATE_FORMATS.find do |regex, _|
      regex.match?(date_string)
    end

    format && Date.strptime(date_string, format[1])
  end
end