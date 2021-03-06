# -*- coding: utf-8 -*-
require 'rails_helper'

RSpec.describe LibrisModsInterface, type: :model do

  describe "generic libris package" do
    before :each do
      mets_package = create(:libris_package)
      mets_package_nonsort = create(:libris_nonsort_package)
      
      @libris_mets_nonsort_interface = mets_package_nonsort.mets_object
      @libris_mods_nonsort_interface = @libris_mets_nonsort_interface.wrapped_object

      @libris_mets_interface = mets_package.mets_object
      @libris_mods_interface = @libris_mets_interface.wrapped_object
    end

    describe "id" do
      it "should return correct ID string" do
        id = @libris_mods_interface.id
        
        expect(id).to be_a String
        expect(id).to eq "663299"
      end
    end

    describe "title" do
      it "should return correct title string" do
        title = @libris_mods_interface.title
        
        expect(title).to be_a String
        expect(title).to eq "Podsol och brunjord"
      end
      it "should return correct title string (with nonsort)" do
        title = @libris_mods_nonsort_interface.title
        
        expect(title).to be_a String
        expect(title).to eq "Den Podsol och brunjord"
      end
    end

    describe "sub_title" do
      it "should return correct sub title string" do
        sub_title = @libris_mods_interface.sub_title
        
        expect(sub_title).to be_a String
        expect(sub_title).to eq "en studie av vegetation och jordmånsbildning inom östra Skånes ås- och skogsområden"
      end
    end

    describe "language" do
      it "should return correct language string" do
        language = @libris_mods_interface.language
        
        expect(language).to be_a String
        expect(language).to eq "swe"
      end
    end

    describe "type_of_record" do
      it "should return correct type_of_record string" do
        type_of_record = @libris_mods_interface.type_of_record
        
        expect(type_of_record).to be_a Array
        expect(type_of_record).to include("book")
        expect(type_of_record).to include("theses")
        expect(type_of_record).to include("text")
      end
    end

    describe "search_string" do
      it "should return correct search string" do
        search_string = @libris_mods_interface.search_string
        
        expect(search_string).to be_a String
        expect(search_string).to match(/podsol och brunjord/)
        expect(search_string).to match(/en studie av vegetation och jordmansbildning inom ostra skanes as- och skogsomraden/)
        expect(search_string).to match(/podsol and brown earth/)
        expect(search_string).to match(/a study in vegetation and soil formation in east scania/)
        expect(search_string).to match(/nils linnermark.*second name/)
      end
    end

    describe "authors" do
      it "should return correct author string" do
        authors = @libris_mods_interface.authors
        
        expect(authors).to be_a String
        expect(authors).to eq "Nils Linnermark (1908-); Second Name (1999-)"
      end
    end

    describe "source" do
      it "should return correct source string" do
        source = @libris_mods_interface.source
        
        expect(source).to be_a String
        expect(source).to eq "libris"
      end
    end

    describe "year" do
      it "should return correct year" do
        year = @libris_mods_interface.year
        
        expect(year).to be_a String
        expect(year).to eq "1960"
      end
    end
  end

  describe "non-generic libris data" do
    before :each do
      MetsPackage.sync
      @libris_mods_interface = MetsPackage.find_by_name("GUB0101403").mets_object.wrapped_object
      @package = MetsPackage.find_by_name("GUB0104571")
      @ordchron_package = MetsPackage.find_by_name("GUB0104143")
    end

    describe "language" do
      it "should have package" do
        expect(@package).to_not be_nil
      end
    end

    describe "multiple dateIssued" do
      it "should list outmost dates available" do
        expect(@libris_mods_interface.year).to eq("1899-1933")
      end
    end

    describe "publisher" do
      it "should return first publisher" do
        year = @libris_mods_interface.publisher
        
        expect(year).to be_a String
        expect(year).to eq "D. F. Bonniers boktryckeri A.-B."
      end
    end

    describe "ordinals" do
      it "should have ordinals in metadata" do
        expect(@ordchron_package.metadata['ordinal_1']).to_not be_nil
        expect(@ordchron_package.metadata['ordinal_2']).to_not be_nil
      end
    end

    describe "chronologicals" do
      it "should have chronologicals in metadata" do
        expect(@ordchron_package.metadata['chronological_1']).to_not be_nil
        expect(@ordchron_package.metadata['chronological_2']).to_not be_nil
        expect(@ordchron_package.metadata['chronological_3']).to_not be_nil
      end
    end
  end
end
