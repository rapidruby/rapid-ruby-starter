class DisposableEmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if DisposableEmailService.disposable?(value)
      record.errors.add(attribute, (options[:message] || "is a disposable email address and is banned"))
    end
  end
end
