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
    
    def edit
        @blog = Blog.find(params[:blog_id])
        @entry = @blog.entries.find(params[:id])
    end

    def show
        @blog = Blog.find(params[:blog_id])
        if @blog.entries.exists?(params[:id])
            @entry = @blog.entries.find(params[:id])
            @comments = @entry.comments
        end
    end

    def update
        @blog = Blog.find(params[:blog_id])
        @entry = @blog.entries.find(params[:id])
        if @entry.update(entry_params)
            redirect_to blog_entry_url(@blog.id, @entry.id)
        else
            render 'edit'
        end
    end

    def destroy
        @blog = Blog.find(params[:blog_id])
        @entry = Entry.find(params[:id])
        if @entry.destroy
            flash[:notice] = "削除しました"
            redirect_to blog_path(@blog.id)
        else
            flash[:notice] = "削除に失敗しました"
            render blog_path(@blog.id)
        end
    end

    private
    def entry_params
        params.require(:entry).permit(:title, :body, :blog_id)
    end 
end
