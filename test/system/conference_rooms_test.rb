require "application_system_test_case"

class ConferenceRoomsTest < ApplicationSystemTestCase
  setup do
    @conference_room = conference_rooms(:one)
  end

  test "visiting the index" do
    visit conference_rooms_url
    assert_selector "h1", text: "Conference Rooms"
  end

  test "creating a Conference room" do
    visit conference_rooms_url
    click_on "New Conference Room"

    fill_in "Name", with: @conference_room.name
    click_on "Create Conference room"

    assert_text "Conference room was successfully created"
    click_on "Back"
  end

  test "updating a Conference room" do
    visit conference_rooms_url
    click_on "Edit", match: :first

    fill_in "Name", with: @conference_room.name
    click_on "Update Conference room"

    assert_text "Conference room was successfully updated"
    click_on "Back"
  end

  test "destroying a Conference room" do
    visit conference_rooms_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Conference room was successfully destroyed"
  end
end
