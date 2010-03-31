class AddGenreAndHiroToReview < ActiveRecord::Migration
  def self.up
    add_column :reviews, :genre, :string
    add_column :reviews, :genre_wk, :string
    add_column :reviews, :hiro, :string
  end

  def self.down
    remove_column :reviews, :hiro
    remove_column :reviews, :genre_wk
    remove_column :reviews, :genre
  end
end
