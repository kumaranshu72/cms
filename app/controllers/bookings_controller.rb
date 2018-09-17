class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]

  # GET /bookings
  # GET /bookings.json
  def index
    @bookings = Booking.all
  end

  # GET /bookings/1
  # GET /bookings/1.json
  def show
  end

  # GET /bookings/new
  def new
    @booking = Booking.new
    @room = ConferenceRoom.all
    @currentUser = current_user.id
  end

  # GET /bookings/1/edit
  def edit
  end

  # POST /bookings
  # POST /bookings.json
  def create
    from_date = booking_params["from(1i)"]+'-'+booking_params["from(2i)"]+'-'+booking_params["from(3i)"]
    from_time = booking_params["from(4i)"]+'-'+booking_params["from(5i)"]
    to_date = booking_params["to(1i)"]+'-'+booking_params["to(2i)"]+'-'+booking_params["to(3i)"]
    to_time = booking_params["to(4i)"]+'-'+booking_params["to(5i)"]
    curr_date_time = DateTime.now.to_s
    from_date_holiday = Holiday.find_by(holiday_date: from_date)
    to_date_holiday = Holiday.find_by(holiday_date: to_date)
    if (from_date+"T"+from_time < to_date+"T"+to_time) && (from_date+"T"+from_time >= curr_date_time[0...16]) && !from_date_holiday.present? && !to_date_holiday.present?
      @booking = Booking.new(booking_params)
      respond_to do |format|
        if @booking.save
          format.html { redirect_to @booking, notice: 'Booking was successfully created.' }
          format.json { render :show, status: :created, location: @booking }
        else
          format.html { render :new }
          format.json { render json: @booking.errors, status: :unprocessable_entity }
        end
      end
    else
       flash[:danger] = 'Enter Valid Date Time.'
      redirect_to '/bookings/new'
    end
  end

  # PATCH/PUT /bookings/1
  # PATCH/PUT /bookings/1.json
  def update
    respond_to do |format|
      if @booking.update(booking_params)
        format.html { redirect_to @booking, notice: 'Booking was successfully updated.' }
        format.json { render :show, status: :ok, location: @booking }
      else
        format.html { render :edit }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookings/1
  # DELETE /bookings/1.json
  def destroy
    @booking.destroy
    respond_to do |format|
      format.html { redirect_to bookings_url, notice: 'Booking was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_booking
      @booking = Booking.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def booking_params
      params.require(:booking).permit(:user_id, :room_id, :from, :to, :status)
    end
end
