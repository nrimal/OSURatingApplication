class FacilityController < ApplicationController

#deletes a user written post/review
    def delete
        postID = params[:id]
        review = Review.find(postID)
        room = Room.find(review.room_id)
        allReviews = Review.where('room_id = ?', room.id)
        review.destroy
        redirect_to(:back)
    end


# Returns a blank form to create a review for a facility
    def new
        # Check if user is logged in
        if !user_signed_in?
            redirect_to controller: 'user', action: 'notLoggedIn'
        else
            # Get all building names in ascending order
            @buildings = Building.all.order(name: :asc).to_a.map {
                |building| building.name
            }

            # Same with facility types and room numbers
            @facilitytypes = FacilityType.all.order(ftype: :asc).to_a.map {
                |facilityType| facilityType.ftype
            }

            @rooms = Room.all.order(roomNum: :asc).to_a.map {
                |room| room.roomNum
            }
        end
    end

#Given the review parameters in the payload, creates a review in the Database.
#If the room is not already present in the DB, also creates the room.
#Finally, redirects user to the home page.

    def create
        buildingName = params[:building]
        room = params[:room]
        facilityType = params[:facility]
        review = params[:review]
        rating = params[:rating]

        # Validate the building is in our DB
        building = Building.where(name: buildingName)
        if building.count == 0
            # User did not select one of the buildings from the suggested drop down
            flash[:notice] = "You did not select a valid building name. Please make sure you select a building from the drop down suggestions."
            redirect_to '/error'
            return
        end
        buildingId = building.first.id

        # Create room if it is not already in DB
        if Room.where(roomNum: room, building_id: buildingId).count == 0
            facilityTypeId = FacilityType.where(ftype: facilityType).first.id
            Room.create(roomNum: room, building_id: buildingId, facilitytype_id: facilityTypeId)
        end

        # Add review
        roomId = Room.where(roomNum: room, building_id: buildingId).first.id
        Review.create(review: review, rating: rating, user_id: current_user.id, room_id: roomId)

        # Get the number of reviews for this room so we can calculate the new average
        reviews = Review.where(room_id: roomId).to_a
        nReviews = reviews.length
        reviewSum = reviews.reduce(0) { |sum, review| sum + review.rating}

        # Update rating average for room
        currentRoom = Room.find(roomId)
        currentRoom.save

        # Redirect user to resuts page
        redirect_to controller: 'home', action: 'index'
    end

    #Update information about a review in the database 

    def editReview
          # Also sanitize input -- escape any javascript and html
      @building = params[:building]
      @room = params[:room]
      @facilityType = params[:facility]
      @review = params[:review]
      @rating = params[:rating]

      @newReview = Review.find_by_id(params[:id])

      @newReview.review = @review
      @newReview.rating = @rating
      @newReview.save

      roomId = Room.where(roomNum: @room).first.id
      # Get the number of reviews for this room so we can calculate the new average
      reviews = Review.where(room_id: roomId).to_a
      nReviews = reviews.length
      reviewSum = reviews.reduce(0) { |sum, review| sum + review.rating}

      # Update rating average for room
      currentRoom = Room.find(roomId)
      currentRoom.save

      # Redirect user to results page
      redirect_to controller: 'room_page', action: 'roomInfo', id: roomId
    end

    #Used to gather information routed from results controller, to display them on an edit page
    def show
      if !user_signed_in?
          redirect_to controller: 'user', action: 'notLoggedIn'
      else
          # Get all building names in ascending order
          @buildings = Building.all.order(name: :asc).to_a.map {
              |building| building.name
          }

          # Same with facility types and room numbers
          @facilitytypes = FacilityType.all.order(ftype: :asc).to_a.map {
              |facilityType| facilityType.ftype
          }

          @rooms = Room.all.order(roomNum: :asc).to_a.map {
              |room| room.roomNum
          }
      end
      @id = params[:id]
    end
    def edit
    end
end
