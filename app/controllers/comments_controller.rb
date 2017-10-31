class CommentsController < ApplicationController
    def new
        @blog = Blog.find(params[:blog_id])
        @entry = Entry.find(params[:entry_id])
        @comment = Comment.new
    end
    
    def create
        @comment = Comment.new(comment_params)
        @comment.entry_id = params[:entry_id]
        @comment.status = "unapproved"
        pp @comment
        if @comment.save
            redirect_to blog_entry_url(params[:blog_id], params[:entry_id])
        else
            @blog = Blog.find(params[:blog_id])
            @entry = Entry.find(params[:entry_id])
            flash[:notice] = "失敗しました"
            render blog_entry_url(params[:blog_id], params[:entry_id])
        end
    end

    def destroy
        @blog = Blog.find(params[:blog_id])
        @entry = Entry.find(params[:entry_id])
        @comment = Comment.find(params[:id])
        if @comment.destroy
            flash[:notice] = "削除しました"
            redirect_to blog_entry_path(@blog.id, @entry.id)
        else
            flash[:notice] = "削除に失敗しました"
            render blog_entry_path(@blog.id, @entry.id)
        end
    end

    def approve
        @blog = Blog.find(params[:blog_id])
        @entry = Entry.find(params[:entry_id])
        @comment = Comment.find(params[:id])
        @comment.status = 'approved'
        if @comment.save
            flash[:notice] = "承認しました"
            redirect_to blog_entry_path(@blog.id, @entry.id)
        else
            flash[:notice] = "更新に失敗しました"
            render blog_entry_path(@blog.id, @entry.id)
        end
    end

    private
    def comment_params
        params.require(:comment).permit(:body, :blog_id, :entry_id)
    end
end
