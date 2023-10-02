class GoodsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_good, only: [:edit, :update, :destroy]

  def index
    @goods = current_user.goods
  end

  def new
    @good = current_user.goods.build
    @categories = Category.left_joins(:goods)
                          .where(user_id: [current_user.id, nil])
                          .select("categories.*, CASE WHEN categories.name = 'その他' THEN 1 ELSE 0 END AS ordering, MAX(goods.updated_at) AS latest_updated_at")
                          .group("categories.id")
                          .order("ordering, latest_updated_at DESC")
    @good.build_category
    @artists = current_user.artists
    @live_records = current_user.live_records
    return unless params[:live_record_id]

    @good.live_record_id = params[:live_record_id]
  end

  def edit
    @good = current_user.goods.find(params[:id])
    @categories = Category.left_joins(:goods)
                          .where(user_id: [current_user.id, nil])
                          .select("categories.*, CASE WHEN categories.name = 'その他' THEN 1 ELSE 0 END AS ordering, MAX(goods.updated_at) AS latest_updated_at")
                          .group("categories.id")
                          .order("ordering, latest_updated_at DESC")
    @selected_category_id = @good.category_id
    @good.build_category
    @artists = current_user.artists
    @live_records = current_user.live_records
  end

  def create
    @good = current_user.goods.build(good_params)

    @good.date ||= Time.zone.today

    if params[:good][:new_category_name].present?
      category = current_user.categories.create(name: params[:good][:new_category_name])
      category.user = current_user
      @good.category_id = category.id
    end

    if @good.save
      redirect_to goods_path
    else
      @categories = Category.left_joins(:goods)
                            .where(user_id: [current_user.id, nil])
                            .select("categories.*, CASE WHEN categories.name = 'その他' THEN 1 ELSE 0 END AS ordering, MAX(goods.updated_at) AS latest_updated_at")
                            .group("categories.id")
                            .order("ordering, latest_updated_at DESC")
      @good.build_category
      @artists = current_user.artists
      @live_records = current_user.live_records
      render :new
    end
  end

  def update
    @good = current_user.goods.find(params[:id])
    @good.date ||= Time.zone.today
    @good.assign_attributes(good_params)

    if params[:good][:new_category_name].present?
      category = current_user.categories.create(name: params[:good][:new_category_name])
      @good.category_id = category.id
    end

    if Category.exists?(@good.category_id) || @good.category_id.nil?
      if @good.save
        redirect_to goods_path
      else
        @categories = Category.left_joins(:goods)
                              .where(user_id: [current_user.id, nil])
                              .select("categories.*, CASE WHEN categories.name = 'その他' THEN 1 ELSE 0 END AS ordering, MAX(goods.updated_at) AS latest_updated_at")
                              .group("categories.id")
                              .order("ordering, latest_updated_at DESC")
        @good.build_category
        @artists = current_user.artists
        @live_records = current_user.live_records
        render :edit
      end
    else
      @good.errors.add(:category_id, "選択されたカテゴリーは存在しません")
      render :edit
    end
  end

  def destroy
    @good.destroy
    redirect_to goods_path, notice: 'Good was successfully destroyed.'
  end

  private

  def set_good
    @good = current_user.goods.find(params[:id])
  end

  def good_params
    params.require(:good).permit(:name, :price, :quantity, :category_id, :artist_id, :member_id, :live_record_id, :date, category_attributes: [:id, :name, :user_id])
  end
end
