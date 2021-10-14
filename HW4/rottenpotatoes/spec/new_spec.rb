require 'rails_helper'

RSpec.describe Movie, type: :model do
    
    describe 'Checks for director field' do
        it 'Return director with multiple movies' do
            m1 = Movie.create({:title => 'Star Wars', :rating => 'PG', :director => 'George Lucas'})
            m2 = Movie.create({:title => 'THX-1138', :rating => 'R', :director => 'George Lucas'})
            m3 = Movie.create({:title => 'Blade Runner', :director => 'Ridley Scott', :rating => 'PG'})
            directors = Movie.others_by_same_director(m2.director)
            expect(directors.size()).to eq 2
        end
        
        it 'Return director with only one movie' do
            m1 = Movie.create({:title => 'Star Wars', :director => 'George Lucas', :rating => 'PG'})
            m2 = Movie.create({:title => 'THX-1138', :director => 'George Lucas', :rating => 'R'})
            m3 = Movie.create({:title => ' Blade Runner', :director => 'Ridley Scott', :rating => 'PG'})
            directors = Movie.others_by_same_director(m3.director)
            expect(directors.size()).to eq 1
        end
        
        it 'When there are no directors return null' do
            m1 = Movie.create({:title => 'Alien', :rating => 'R'})
            m2 = Movie.create({:title => 'THX-1138', :rating => 'R', :director => 'George Lucas'})
            m3 = Movie.create({:title => ' Blade Runner', :rating => 'PG', :director => 'Ridley Scott'})
            directors = Movie.others_by_same_director(m1.director)
            expect(directors).to eq nil
        end
        
    end
    
end


RSpec.describe MoviesController, type: :controller do
    
    render_views
    describe "Index" do
        it 'should display movie list correctly' do
            Movie.create({:title => 'Alien', :rating => 'R', :release_date => '1977-05-25'})
            Movie.create({:title => 'Star Wars', :rating => 'PG', :release_date => '1977-05-25', :director => 'George Lucas'})
            Movie.create({:title => 'THX-1138', :rating => 'R', :release_date => '1971-03-11', :director => 'George Lucas'})
            Movie.create({:title => ' Blade Runner', :rating => 'PG', :release_date => '1982-06-25', :director => 'Ridley Scott'})
            get :index
            expect(response).to be_successful
            expect(response.body).to include("Alien")
            expect(response.body).to include("Star Wars")
            expect(response.body).to include("THX-1138")
            expect(response.body).to include("Blade Runner")
        end
    end
    
    describe "Destroy" do
        it 'should delete movie' do
            m1 = Movie.create({:title => 'Star Wars', :director => 'George Lucas', :rating => 'PG'})
            m2 = Movie.create({:title => 'THX-1138', :director => 'George Lucas', :rating => 'R'})
            get :destroy, :id => m1.id
            response.should redirect_to(movies_path)
            get :index
            expect(response).to be_successful
            expect(response.body).to include("THX-1138")
        end
    end
    
    describe "Create" do
        it 'should create a new movies' do
            params = ActionController::Parameters.new(movie: {title: "Star Wars", rating: 'PG'})
            post :create, params
            response.code.should == "302"
            response.should redirect_to(movies_path)
            
            params = ActionController::Parameters.new(movie: {title: "THX-1138", rating: 'R'})
            post :create, params
            response.code.should == "302"
            response.should redirect_to(movies_path)
            
            params = ActionController::Parameters.new(movie: {title: "Blade Runner", rating: 'PG'})
            post :create, params
            response.code.should == "302"
            response.should redirect_to(movies_path)
            
            get :index

            expect(response.body).to include("Star Wars")
            expect(response.body).to include("THX-1138")
            expect(response.body).to include("Blade Runner")
        end
    end
         
    describe "update" do
        it 'should update a movie' do
            
            m1 = Movie.create({:title => 'Blaaade Runner', :rating => 'R'})
            params = ActionController::Parameters.new(id: m1.id, movie: { title: "Blade Runner", rating: 'PG'})
            post :update, params
            response.code.should == "302"
            response.should redirect_to(movie_path)
            get :index
            expect(response.body).to include("Blade Runner")
            expect(response.body).to include("PG")
            expect(response.body).not_to include("Blaaade Runner")
            
        end
    end
end

RSpec.describe DirectorsController, type: :controller do
    
    describe 'Directors Page' do
        render_views
        it 'If there are movies by a director' do
            m1 = Movie.create({:title => 'Star Wars', :director => 'George Lucas', :rating => 'PG'})
            m2 = Movie.create({:title => 'THX-1138', :director => 'George Lucas', :rating => 'R'})
            get :show, :id => m1.id
            expect(response.body).to include("Star Wars")
        end
        
        it 'Should redirect to movie list if there are no movies by the director' do
            m1 = Movie.create({:title => 'Alien', :rating => 'R', :release_date => '1977-05-25'})
            m2 = Movie.create({:title => 'Star Wars', :rating => 'PG', :release_date => '1977-05-25', :director => 'George Lucas'})
            m3 = Movie.create({:title => 'THX-1138', :rating => 'R', :release_date => '1971-03-11', :director => 'George Lucas'})
            m4 = Movie.create({:title => ' Blade Runner', :rating => 'PG', :release_date => '1982-06-25', :director => 'Ridley Scott'})
            get :show, :id => m1.id
            response.should redirect_to(movies_path)
        end
    end
end

RSpec.describe MoviesHelper, type: :helper do
    
    describe 'Checks if odd or even' do 
                
        it 'check if even' do
            expect(oddness(2)).to eq 'even'
        end

        it 'check if odd' do
            expect(oddness(1)).to eq 'odd'
        end

        
    end
    
    
end