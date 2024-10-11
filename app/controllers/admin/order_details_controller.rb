class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!

  def update
    @order = Order.find(params[:order_id])
    @order_detail = @order.order_details.find(params[:id])
    if @order_detail.update(order_detail_params) && @order_detail.in_production?
    # もし　@order_detailがアップデートされてかつ、製造ステータスが"製作中"だったら
      @order.in_production!
    # 注文ステータスを"製作中"に変える
    elsif @order.are_all_details_completed?
    # 制作ステータスが全て"制作完了"になったら（モデルで定義したものを呼び出し)
      @order.preparing_shipment!
    # 注文ステータスを"発送準備中"に変える
    end
    redirect_to admin_order_path(@order)
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end

end
