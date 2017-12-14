require 'open-uri'
require 'json'

ftypes = [
    "Bathroom",
    "Lab",
    "Other",
    "Classroom",
    "Study Room",
    "Dorm",
    "Parking Garage",
    "Recreational Facility",
    "Dining Hall"
]

rooms = [
    {
        "building" => 169,
        "roomNum" => "369",
        "type" => 4,
    },
    {
        "building" => 19,
        "roomNum" => "112",
        "type" => 4,
    },
    {
        "building" => 169,
        "roomNum" => "317",
        "type" => 4,
    },
    {
        "building" => 51,
        "roomNum" => "N/A",
        "type" => 5,
    },
    {
        "building" => 35,
        "roomNum" => "Second Floor Study Room",
        "type" => 5,
    }
]

reviews = [
    {
        "review" => "Not a terrible room. I learn a lot in it",
        "rating" => 4,
        "userID" => 2,
        "roomID" => 3
    },
    {
        "review" => "The room is okay but the projector sometimes cuts out. This seems to get in the way of some lectures done by Dr. Shareef.",
        "rating" => 3,
        "userID" => 1,
        "roomID" => 3
    },
    {
        "review" => "A very nice room that is condusive to learning",
        "rating" => 4,
        "userID" => 2,
        "roomID" => 1
    },
    {
        "review" => "Has very nice printers with lots of seating.",
        "rating" => 5,
        "userID" => 1,
        "roomID" => 2
    },
    {
        "review" => "Great place to work for freshmen.",
        "rating" => 5,
        "userID" => 2,
        "roomID" => 2
    },
    {
        "review" => "Great napping spot on the the third floor with great couching.",
        "rating" => 5,
        "userID" => 2,
        "roomID" => 4
    },
    {
        "review" => "Great studying environment. Quiet environment that is also serene.",
        "rating" => 5,
        "userID" => 1,
        "roomID" => 4
    },
    {
        "review" => "Huge room with lots of seating and is quiet and easy to learn at.",
        "rating" => 5,
        "userID" => 1,
        "roomID" => 5
    },
]

ftypes.each do |type|
    FacilityType.create(ftype:type)
end

reviews.each do |review|
    Review.create(review:review["review"], rating:review["rating"], user_id:review["userID"], room_id:review["roomID"])
end

rooms.each do |room|
    Room.create(roomNum:room["roomNum"], building_id:room["building"], facilitytype_id:room["type"])
end
# Create a default user
user = User.new({email: 'brutus@osu.edu', password: 'password', password_confirmation: 'password'})
user.save
user = User.new({email: 'smith.1@osu.edu', password: 'password', password_confirmation: 'password'})
user.save


# This fetches all OSU buildings from https://www.osu.edu/map/buildingindex.php
# and inserts into DB.
# OSU building id's are in the range [001, 1260]
puts "Fetching and inserting all OSU buildings into DB. Grab some coffee, this will probably take a while."
1261.times do |id|
    response = open('https://www.osu.edu/map/inc/google/v2/points.php?query_type=7&query=' + ("%.3d" % id)).read
    if (response != "null")
        responseHash = JSON.parse(response)[0]
        buildingName = responseHash["name"]
        longitude = responseHash["longitude"]
        latitude = responseHash["latitude"]
        Building.create(name:buildingName, longitude:longitude, latitude:latitude)
        puts "Fetched data for and added building \"#{buildingName}\" to the buildings DB."
    end
end
