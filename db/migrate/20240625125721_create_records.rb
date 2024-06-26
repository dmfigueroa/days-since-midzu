class CreateRecords < ActiveRecord::Migration[7.1]
  def change
    create_table :records do |t|
      t.date :last_stream
      t.date :said

      t.timestamps
    end
  end
end
