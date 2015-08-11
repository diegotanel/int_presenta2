require 'spec_helper'

describe ElencoEnGiraController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      get 'show'
      response.should be_success
    end
  end

  describe "GET 'errores'" do
    it "returns http success" do
      get 'errores'
      response.should be_success
    end
  end

end
