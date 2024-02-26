class CreatePolicies < ActiveRecord::Migration[7.0]
  def change
    create_table :policies do |t|
      t.date :issued_date
      t.date :end_coverage_date

      t.timestamps
    end
  end
end
