class MessagesController < ApplicationController
  def create
    @chatroom = Chatroom.find(params[:chatroom_id])
    @message = @chatroom.messages.new(message_params)
    @message.user = current_user

    if @message.save
      ChatroomChannel.broadcast_to(
        @chatroom,
        message: render_to_string(partial: "shared/message", locals: { message: @message }),
        sender_id: @message.user.id,
        avatar_url: @message.user.avatar.attached? ? url_for(@message.user.avatar) : nil,
        sender_name: @message.user.full_name,
        profile_url: user_path(@message.user)
      )
      head :ok
    else
      @messages = @chatroom.messages.order(created_at: :desc).limit(30)
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
