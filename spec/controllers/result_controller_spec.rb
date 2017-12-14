require "rails_helper"

describe ResultController do

  it "GET #showAll" do
    allRoom = Room.all
    get :showResult
    assigns(:rooms) == ([allRoom])
  end
  
  render_views

  it "renders the :showAll view" do
    get :showResult
    expect(response).to render_template("showResult") 
  end
  
  it "renders the :showAll view" do
    get :showResult
    expect(response.body).to match("Room")
  end

  it "routes /result.showResult to the result controller" do
    expect(:get => "/result/showResult").to route_to(
      :controller => "result", 
      :action => "showResult")
  end

end