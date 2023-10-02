class StatisticsController < ApplicationController
  def index
    today = Date.today
    this_month = today.month

    # ライブ記録の総数
    @total_live_records = current_user.live_records.count

    # 今月のライブ回数
    @this_month_live_count = current_user.live_records.where("strftime('%m', date) = ?", this_month.to_s).count

    # ライブに参加したアーティスト数
    @unique_artist_count = current_user.live_records.joins(:artist).distinct.count('artists.id')

    # 半年間のライブ総数
    @half_year_live_count = current_user.live_records.where(date: 6.months.ago.beginning_of_day..Time.zone.now.end_of_day).count

    # ライブの総支出
    @live_expense = current_user.live_records.sum("COALESCE(ticket_price, 0) + COALESCE(drink_price, 0)")

    # グッズの総支出
    @goods_expense = current_user.goods.where.not(price: nil).sum('price * quantity')

    # ライブ記録とグッズ記録の支出の総合計
    live_total = current_user.live_records.sum("COALESCE(ticket_price, 0) + COALESCE(drink_price, 0)")
    goods_total = current_user.goods.where.not(price: nil).sum('price * quantity')
    @total_expense = live_total + goods_total

    # 今月のグッズ購入数
    @this_month_goods_count = current_user.goods.where("strftime('%m', date) = ?", this_month.to_s).sum(:quantity)

    # メンバー別のグッズ購入ランキング
    @member_goods_ranking = current_user.goods.joins(:member).group('members.name').sum('goods.price * goods.quantity')

    # よく参加する会場Top3
    @top_venues = current_user.live_records.group(:venue_id).order('count_id DESC').limit(3).count(:id)

    @monthly_live_labels = (0..11).to_a.reverse.map do |months_ago|
      l(months_ago.months.ago, format: "%Y年%B")
    end

    # 月別ライブ数（12か月分のデータ）
    @monthly_live_counts = (0..11).to_a.reverse.map do |months_ago|
      month_start = months_ago.months.ago.beginning_of_month
      month_end = months_ago.months.ago.end_of_month
      current_user.live_records.where(date: month_start..month_end).count
    end

    # ジャンル別ライブ回数
    @genre_counts = current_user.live_records.joins(:artist).group('artists.genre').count

     # 週別ライブ数（7日分のデータ）
    @weekly_live_counts = {}
    @weekly_live_counts = current_user.live_records.where(date: 6.months.ago..Time.zone.now).group_by { |record| record.date.wday }.map { |wday, records| [wday, records.count] }.to_h


    # グッズカテゴリ別支出
    @category_expenses = current_user.goods.joins(:category).group('categories.name').sum('goods.price * goods.quantity')
  end
end
