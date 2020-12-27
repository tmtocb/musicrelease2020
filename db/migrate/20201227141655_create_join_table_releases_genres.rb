class CreateJoinTableReleasesGenres < ActiveRecord::Migration[6.0]
  def change
    create_join_table :releases, :genres do |t|
      t.index :release_id
      t.index :genre_id
    end
  end
end
