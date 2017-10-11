class EntriesController < ApplicationController
    def new
        @entry = Entry.new
        @blog = Blog.find(params[:blog_id])
    end
    
    def create
        @entry = Entry.new(entry_params)
        @entry.blog_id = params[:blog_id]
        if @entry.save
            redirect_to blog_url(params[:blog_id])
        else
            @blog = Blog.find(params[:blog_id])
            flash[:notice] = "失敗しました"
            render 'new'
        end
    end
    
    private
    def entry_params
        params.require(:entry).permit(:title, :body, :blog_id)
    end 
end
