class ChangeRecordsFieldsToDatetime < ActiveRecord::Migration[7.1]
  def change
    change_column :records, :last_stream, :datetime
    change_column :records, :said, :datetime
  end
end
