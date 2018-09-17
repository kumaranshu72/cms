class SearchController < ApplicationController
  def search_page
  end

  def search_room
    @conference_room = ConferenceRoom.find_by_sql(["SELECT conference_rooms.name,conference_rooms.id FROM conference_rooms LEFT JOIN room_facilities ON room_facilities.room_id = conference_rooms.id JOIN factilities ON factilities.id = room_facilities.facility_id WHERE factilities.name = ?", params[:name]])
  end
end
