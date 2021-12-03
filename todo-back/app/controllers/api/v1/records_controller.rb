module Api
  module V1
    class RecordsController < ApplicationController
      before_action :set_record, only: [:show, :update, :destroy]

      # GET /records
      def index
        @records = Record.all
        
        render json: @records
      end

      # POST /records
      def create
        @record = Record.new(record_params)

        if @record.save
          render json: @record, status: :created
        else
          render json: @record.errors.full_messages, status: :unprocessable_entity
        end
      end

      # DELETE /records/1
      def destroy
        @record.destroy
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_record
          @record = Record.find(params[:id])
        end

        # Only allow a list of trusted parameters through.
        def record_params
          params.require(:record).permit(:name, :rating)
        end
    end
  end
end
