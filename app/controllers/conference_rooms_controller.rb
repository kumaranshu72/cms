class ConferenceRoomsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_conference_room, only: [:show, :edit, :update, :destroy]

  # GET /conference_rooms
  # GET /conference_rooms.json
  def index
    @conference_rooms = ConferenceRoom.all
  end

  # GET /conference_rooms/1
  # GET /conference_rooms/1.json
  def show
    @conference_rooms = ConferenceRoom.find_by(id: params[:id])
    @facility = Factility.find_by_sql(["SELECT factilities.name FROM factilities LEFT JOIN room_facilities ON room_facilities.facility_id = factilities.id JOIN conference_rooms ON conference_rooms.id = room_facilities.room_id WHERE conference_rooms.id = ?", params[:id]])
  end

  # GET /conference_rooms/new
  def new
    @conference_room = ConferenceRoom.new
  end

  # GET /conference_rooms/1/edit
  def edit
    #@facility = Factility.find_by_sql(["SELECT factilities.name FROM factilities LEFT JOIN room_facilities ON room_facilities.facility_id = factilities.id JOIN conference_rooms ON conference_rooms.id = room_facilities.room_id WHERE conference_rooms.id = ?", params[:id]])
  end

  # POST /conference_rooms
  # POST /conference_rooms.json
  def create
    @conference_room = ConferenceRoom.new(conference_room_params)
    split_facility = conference_room_facility_params[:facility].split(',')
    respond_to do |format|
      if @conference_room.save
        split_facility.each { |t|
          @facility = Factility.find_by(name: t)
          if @facility.nil?
            @facility_ = Factility.create(name: t)
            @roomfacility = RoomFacility.create(room_id: ConferenceRoom.last.id,facility_id: Factility.last.id)
          else
            @roomfacility = RoomFacility.create(room_id: ConferenceRoom.last.id,facility_id: Factility.last.id)
          end
        }
        format.html { redirect_to @conference_room, notice: 'Conference room was successfully created.' }
        format.json { render :show, status: :created, location: @conference_room }
      else
        format.html { render :new }
        format.json { render json: @conference_room.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /conference_rooms/1
  # PATCH/PUT /conference_rooms/1.json
  def update
    respond_to do |format|
      if @conference_room.update(conference_room_params)
        format.html { redirect_to @conference_room, notice: 'Conference room was successfully updated.' }
        format.json { render :show, status: :ok, location: @conference_room }
      else
        format.html { render :edit }
        format.json { render json: @conference_room.errors, status: :unprocessable_entity }
      end
    end
  end

  def search_page
  end

  def search
    @conference_room = ConferenceRoom.find_by_sql(["SELECT conference_rooms.name,conference_rooms.id FROM conference_rooms LEFT JOIN room_facilities ON room_facilities.room_id = conference_rooms.id JOIN factilities ON factilities.id = room_facilities.facility_id WHERE factilities.name = ?", params[:name]])
  end

  # DELETE /conference_rooms/1
  # DELETE /conference_rooms/1.json
  def destroy
    @conference_room.destroy
    respond_to do |format|
      format.html { redirect_to conference_rooms_url, notice: 'Conference room was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_conference_room
      @conference_room = ConferenceRoom.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def conference_room_params
      params.require(:conference_room).permit(:name)
    end

    def conference_room_facility_params
      params.require(:conference_room).permit(:facility)
    end
end
