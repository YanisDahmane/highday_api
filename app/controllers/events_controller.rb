class EventsController < ApplicationController
  before_action :authenticate_request
  before_action :event_exits?, only: [:show, :destroy]
  before_action :is_owner_of_event?, only: [:destroy]

  def index
    @events = @current_user.all_events
    render json: ActiveModel::Serializer::CollectionSerializer.new(@events, each_serializer: EventSerializer).to_json, status: :ok
  end

  def show
    @event = Event.find(params[:id])
    render json: EventSerializer.new(@event).to_json, status: :ok
  end

  def create
    @event = Event.create!(event_params)
    if @event.save
      render json: EventSerializer.new(@event).to_json, status: :created
    else
      render json: { errors: @event.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def destroy
    @event = Event.find(params[:id])

    if @event.destroy
      render json: { message: "Event deleted" }, status: :ok
    else
      render json: { errors: @event.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  private

  def event_params
    params.permit(:title, :description, :start_at, :end_at, :owner_id)
  end

  def event_exits?
    unless Event.exists?(params[:id])
      render json: { message: "Event not found" }, status: :not_found
    end
  end

  def is_owner_of_event?
    unless Event.find(params[:id]).owner == @current_user
      render json: { message: "You are not the owner of this event" }, status: :unauthorized
    end
  end
end
