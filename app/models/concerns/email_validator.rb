class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /[-a-zA-Z0-9._]+@[a-zA-Z0-9\-._ ]+\.[a-zA-Z0-9\-._ ]+/
      record.errors[attribute] << (options[:message] || "#{value} n'est pas valide")
    end 
  end
end 