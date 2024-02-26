class CreateInsureds < ActiveRecord::Migration[7.0]
  def change
    create_table :insureds do |t|
      t.string :name
      t.string :cpf
      t.belongs_to :policy, null: false, foreign_key: true

      t.timestamps
    end
  end
end
