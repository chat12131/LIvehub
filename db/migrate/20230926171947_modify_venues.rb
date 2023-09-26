class ModifyVenues < ActiveRecord::Migration[6.1]
  def change
    # addressカラムを削除
    remove_column :venues, :address

    # latitudeとlongitudeカラムを追加
    add_column :venues, :latitude, :float
    add_column :venues, :longitude, :float

    # areaカラムを追加
    add_column :venues, :area, :string
  end
end
