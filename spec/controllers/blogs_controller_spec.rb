require 'rails_helper'

RSpec.describe BlogsController, type: :controller do
    describe 'GET #index' do
        before do
            @dog = create(:blog, id: 1, title: 'dog' )
            @cat = create(:blog, id: 2, title: 'cat' )
            get 'index'
        end

        it "@blogsに全てのBlogが入っていること" do
            expect(assigns(:blogs)).to match_array([@dog,@cat])            
        end

        it "renders the :index template" do
            get :index
            expect(response).to render_template :index
        end

    end
    
    describe 'POST #create' do
        it "新規作成後に@blogのshowに遷移すること" do
            post :create, params: { blog: attributes_for(:blog)}
            expect(response).to redirect_to blog_path(assigns[:blog])
        end
    end
end
