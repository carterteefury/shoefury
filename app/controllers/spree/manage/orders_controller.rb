module Spree
  module Manage
    class OrdersController < Spree::Manage::BaseController
      before_filter :check_authorization
      require 'spree/core/gateway_error'

      respond_to :html

      def index
        params[:q] ||= {}

        #@search = Order.by_brand(current_user.brand_id).where("shipment_state != 'shipped'").search(params[:q])
        @search = Order.unshipped(current_user.brand_id).search(params[:q])
        @orders = @search.result.includes([:user, :shipments, :payments]).page(params[:page]).per(Spree::Config[:orders_per_page])
        respond_with(@orders)
      end

      def complete
        params[:q] ||= {}
        params[:q][:completed_at_not_null] ||= '1' if Spree::Config[:show_only_complete_orders_by_default]
        @show_only_completed = params[:q][:completed_at_not_null].present?
        params[:q][:meta_sort] ||= @show_only_completed ? 'completed_at.desc' : 'created_at.desc'

        if !params[:q][:created_at_gt].blank?
          params[:q][:created_at_gt] = Time.zone.parse(params[:q][:created_at_gt]).beginning_of_day rescue ""
        end

        if !params[:q][:created_at_lt].blank?
          params[:q][:created_at_lt] = Time.zone.parse(params[:q][:created_at_lt]).end_of_day rescue ""
        end

        if @show_only_completed
          params[:q][:completed_at_gt] = params[:q].delete(:created_at_gt)
          params[:q][:completed_at_lt] = params[:q].delete(:created_at_lt)
        end

        @search = Order.shipped(current_user.brand_id).search(params[:q])
        @orders = @search.result.includes([:user, :shipments, :payments]).page(params[:page]).per(Spree::Config[:orders_per_page])
        respond_with(@orders)
      end

      def show
        respond_with(@order)
      end

      private
      def load_order
        @order ||= Order.find_by_number(params[:id], :include => :adjustments) if params[:id]
        @order
      end

      def check_authorization

        load_order
        session[:access_token] ||= params[:token]

        resource = @order || Spree::Order
        action = params[:action].to_sym

        authorize! :manage, resource, session[:access_token]
      end
    end
  end
end
