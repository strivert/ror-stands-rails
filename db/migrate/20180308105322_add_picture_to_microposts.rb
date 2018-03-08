# rails generate migration add_picture_to_microposts picture:string

# Images uploaded with CarrierWave should be associated with a corresponding attribute in an Active Record model,
# which simply contains the name of the image file in a string field.

class AddPictureToMicroposts < ActiveRecord::Migration[5.1]
  def change
    add_column :microposts, :picture, :string
  end
end
