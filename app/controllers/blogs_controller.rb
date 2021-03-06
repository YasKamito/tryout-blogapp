class BlogsController < ApplicationController
    def index
        @blogs = Blog.all
    end

    def new
        @blog = Blog.new
    end

    def create
        @blog = Blog.new(blog_params)

        if @blog.save
            redirect_to blog_url(@blog)
        else
            render 'new'
        end

    end

    def edit
        @blog = Blog.find(params[:id])
    end

    def show
        #@blog = Blog.find(params[:id])
        #@blog = Blog.where("id = #{params[:id]}").first
        @blog = Blog.where("id = ?", params[:id]).first
        @entries = @blog.entries
    end

    def update
        @blog = Blog.find(params[:id])
        if @blog.update(blog_params)
            redirect_to blog_url(@blog)
        else
            render 'edit'
        end
    end

    def destroy
        @blog = Blog.find(params[:id])
        if @blog.destroy
            flash[:notice] = "削除しました"
            redirect_to blogs_path
        else
            flash[:notice] = "削除に失敗しました"
            render blogs_path
        end
    end

    private
    def blog_params
        params.require(:blog).permit(:title)
    end 

end
