class MessagesController < ApplicationController
    before_action :authenticate_user!

    def create
      if Entry.where(user_id: current_user.id, room_id: params[:message][:room_id]).present?
        @message = Message.new(message_params)
        if @message.save
            redirect_to "/rooms/#{@message.room_id}"
        end
      else
        redirect_back(fallback_location: root_path)
      end
    end

    def destroy
         @message = Message.find(params[:id])

      if @message.user == current_user
         @message.destroy
         flash[:notice] = "メッセージを削除しました"
      else
         flash[:alert] = "削除できません"
    end

         redirect_to room_path(@message.room_id)
end
    
    private 
    def message_params
        params.require(:message).permit(:user_id, :body, :room_id, :image).merge(user_id: current_user.id)
    end
  end