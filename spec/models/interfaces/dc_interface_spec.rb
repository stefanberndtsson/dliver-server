# -*- coding: utf-8 -*-
require 'rails_helper'

RSpec.describe DcInterface, type: :model do
  before :each do
    mets_package = create(:dc_package)
    @document_mets_interface = mets_package.mets_object
    @dc_interface = @document_mets_interface.wrapped_object
  end

  describe "id" do
    it "should return correct ID string" do
      id = @dc_interface.id
      
      expect(id).to be_a String
      expect(id).to eq "gupea:2077/12345"
    end
  end

  describe "title" do
    it "should return correct title string" do
      title = @dc_interface.title
      
      expect(title).to be_a String
      expect(title).to eq "Test title"
    end
  end

  describe "sub_title" do
    it "should return correct sub title string" do
      sub_title = @dc_interface.sub_title
      
      expect(sub_title).to be_a String
      expect(sub_title).to eq ""
    end
  end

  describe "language" do
    it "should return correct language string" do
      language = @dc_interface.language
      
      expect(language).to be_a String
      expect(language).to eq "swe"
    end
  end

  describe "type_of_record" do
    it "should return correct type_of_record string" do
      type_of_record = @dc_interface.type_of_record
      
      expect(type_of_record).to be_a Array
      expect(type_of_record).to include("book")
    end
  end

  describe "search_string" do
    it "should return correct search string" do
      search_string = @dc_interface.search_string
      
      expect(search_string).to be_a String
      expect(search_string).to match(/test title/)
      expect(search_string).to match(/test author/)
    end
  end

  describe "authors" do
    it "should return correct author string" do
      authors = @dc_interface.authors
      
      expect(authors).to be_a String
      expect(authors).to eq "Test author"
    end
  end

  describe "source" do
    it "should return correct source string" do
      source = @dc_interface.source
      
      expect(source).to be_a String
      expect(source).to eq "dc"
    end
  end

  describe "year" do
    it "should return correct year" do
      year = @dc_interface.year
      
      expect(year).to be_a String
      expect(year).to eq "1966"
    end
  end
end
