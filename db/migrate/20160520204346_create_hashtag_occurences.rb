class CreateHashtagOccurences < ActiveRecord::Migration
  def change
    create_table :hashtag_occurences do |t|
      t.belongs_to :message, index: true
      t.belongs_to :hashtag, index: true

      t.integer :quantity

      t.timestamps null: false
    end
  end
end
