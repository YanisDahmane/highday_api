class EventsController < ApplicationController
  before_action :authenticate_request
  before_action :event_exits?, only: [:show, :destroy, :update]
  before_action :is_owner_of_event?, only: [:destroy]

  def index
    @events = @current_user.all_events
    render json: ActiveModel::Serializer::CollectionSerializer.new(@events, each_serializer: EventSerializer).to_json, status: :ok
  end

  def show
    render json: EventSerializer.new(@event).to_json, status: :ok
  end

  def create
    @event = Event.new(event_params)
    @event.owner = @current_user
    if @event.save
      @event.members << User.where(id: params[:members_ids])
      render json: EventSerializer.new(@event).to_json, status: :created
    else
      render json: { errors: @event.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def update
    if @event.update(event_params)
      if params[:members_ids].present?
        member_ids = params[:members_ids]
        existing_member_ids = @event.members.pluck(:id)
        new_member_ids = member_ids - existing_member_ids
        removed_member_ids = existing_member_ids - member_ids

        @event.members << User.where(id: new_member_ids)

        @event.members.delete(User.where(id: removed_member_ids))
      end

      render json: EventSerializer.new(@event).to_json, status: :ok
    else
      render json: { errors: @event.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def destroy
    if @event.destroy
      render json: { message: "Event deleted" }, status: :ok
    else
      render json: { errors: @event.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :start_at, :end_at)
  end

  def event_exits?
    unless Event.exists?(params[:id])
      render json: { message: "Event not found" }, status: :not_found
    end
    @event = Event.find(params[:id])
    p "event found"
    p @event
  end

  def is_owner_of_event?
    unless Event.find(params[:id]).owner == @current_user
      render json: { message: "You are not the owner of this event" }, status: :unauthorized
    end
  end
end
