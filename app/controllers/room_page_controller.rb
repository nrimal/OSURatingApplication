class RoomPageController < ApplicationController

  # Gets information for a particular room and renders a page for it and shows room rating, and location on google maps(done on view)
  def roomInfo

    @result = Room.find(params[:id])

    @building = Building.find(@result.building_id).name
    @buildinLong = Building.find(@result.building_id).longitude
    @buildingLat = Building.find(@result.building_id).latitude
    @room = @result.roomNum
    @facility = @result.facilitytype_id

    @reviews = []
    @reviews = (Review.where('room_id = ?', params[:id])).order(created_at: :desc)

    @numberOfReviews = @reviews.length
    if @numberOfReviews != 0 then
        @avgReview = (@reviews.reduce(0) { |sum, current| sum + current.rating }) / @numberOfReviews.to_f
    else
        @avgReview = 0.0
    end

  end

end
