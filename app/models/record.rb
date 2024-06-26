class Record < ApplicationRecord
  validate :only_one_record

  private

  def only_one_record
    if Record.count > 0 && self.new_record?
      errors.add(:base, "Only one record is allowed for this model")
    end
  end
end
