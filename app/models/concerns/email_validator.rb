class EmailValidator < ActiveModel::Validator
  def validate(record)
    unless record.email.match?(/[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+/)
      record.errors[:email] << "non valide"
    end 
  end
end 