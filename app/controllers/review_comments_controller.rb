class ReviewCommentsController < ApplicationController
  # GET /review_comments
  # GET /review_comments.xml
  def index
    set_status_list
    @review_comments = ReviewComment.find(:all, :order => 'reviews.body DESC', :include => [:review, :student])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @review_comments }
    end
  end

  # GET /review_comments/1
  # GET /review_comments/1.xml
  def show
    set_status_list
    @review_comment = ReviewComment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @review_comment }
    end
  end

  # GET /review_comments/new
  # GET /review_comments/new.xml
  def new
    @review_comment = ReviewComment.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @review_comment }
    end
  end

  # GET /review_comments/1/edit
  def edit
    @review_comment = ReviewComment.find(params[:id])
  end

  def edit_by_student
    @review_comment = ReviewComment.find(params[:id])
    @review_comment.status = 1
  end

  def edit_by_teachar
    @review_comment = ReviewComment.find(params[:id])
  end

  # POST /review_comments
  # POST /review_comments.xml
  def create
    @review_comment = ReviewComment.new(params[:review_comment])
    @review_comment.status = 0 if @review_comment.status == nil
    respond_to do |format|
      if @review_comment.save
        notice_to_comment_checker if @review_comment.status == 1
        flash[:notice] = _('ReviewComment was successfully created.')
        format.html { redirect_to(:action => 'show', :controller => 'reviews',:id => @review_comment.review_id) }
        format.xml  { render :xml => @review_comment, :status => :created, :location => @review_comment }
      else
#        format.html { render :action => "new" }
#       flash[:notice] = _('error error eroor') if @review_comment.content == nil
        flash[:warning] = _('no comment, please re input') if @review_comment.content == ""
        format.html { redirect_to(:action => 'show', :controller => 'reviews',:id => @review_comment.review_id) }
        format.xml  { render :xml => @review_comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /review_comments/1
  # PUT /review_comments/1.xml
  def update
    @review_comment = ReviewComment.find(params[:id])
#    @review_comment.status = 0 if @review_comment.status == nil
#p @review_comment
#    notice_to_comment_checker if @review_comment.status == 1

    respond_to do |format|
      if @review_comment.update_attributes(params[:review_comment])
        notice_to_comment_checker if @review_comment.status == 1
        flash[:notice] = _('ReviewComment was successfully updated.')
        format.html { redirect_to(:action => 'show', :id => @review_comment) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @review_comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update_by_student
    @review_comment = ReviewComment.find(params[:id])
#    @review_comment.status = 0 if @review_comment.status == nil
#p @review_comment
#    notice_to_comment_checker if @review_comment.status == 1

    respond_to do |format|
      if @review_comment.update_attributes(params[:review_comment])
#      if @review_comment.save
        notice_to_comment_checker if @review_comment.status == 1
        flash[:notice] = _('ReviewComment was successfully updated.')
        format.html { redirect_to(:action => 'show', :id => @review_comment) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @review_comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update_by_teachar
    @review_comment = ReviewComment.find(params[:id])

#p @review_comment
#    notice_to_comment_checker

    respond_to do |format|
      if @review_comment.update_attributes(params[:review_comment])
        flash[:notice] = _('ReviewComment was successfully updated.')
        format.html { redirect_to(:action => 'show', :id => @review_comment) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @review_comment.errors, :status => :unprocessable_entity }
      end
    end
  end


  def update_from_review
    @review_comment = ReviewComment.find(params[:id])
#    p @review_comment
#    @review_comment.status = 0 if @review_comment.status == nil or @review_comment.status >> 1
#    p @review_comment
#    notice_to_comment_checker if @review_comment.status == 1

    respond_to do |format|
      if @review_comment.update_attributes(params[:review_comment])
#      if @review_comment.save
        notice_to_comment_checker if @review_comment.status == 1
        flash[:notice] = _('ReviewComment was successfully updated.')
        format.html { redirect_to(:action => 'show', :controller => 'reviews', :id => @review_comment.review_id) }
        format.xml  { head :ok }
      else
#        format.html { render :action => "edit" }
        format.html { redirect_to(:action => 'show', :controller => 'reviews', :id => @review_comment.review_id) }
        format.xml  { render :xml => @review_comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /review_comments/1
  # DELETE /review_comments/1.xml
  def destroy
    @review_comment = ReviewComment.find(params[:id])
    @review_comment.destroy
    flash[:notice] = _('ReviewComment was successfully deleted.')
    respond_to do |format|
      format.html { redirect_to(:action => 'show', :controller => 'reviews', :id => @review_comment.review_id) }
      format.xml  { head :ok }
    end
  end

  def destroy_from_index
    @review_comment = ReviewComment.find(params[:id])
    @review_comment.destroy
    flash[:notice] = _('ReviewComment was successfully deleted.')
    respond_to do |format|
      format.html { redirect_to(:action => 'index') }
      format.xml  { head :ok }
    end
  end

  private

  def notice_to_comment_checker
    @teachar1 = User.find(:first, :conditions => ["group_id = ? and level = 3", session[:user].group_id]).email_pc
  #  @teachar2 = User.find(:second, :conditions => ["group_id = ? and level = 3", session[:user].group_id]).email_pc

    @teachar3 = User.find_by_sql("SELECT email_pc from users WHERE group_id  = '" + session[:user].group_id.to_s + "' and level = 3")

    #p @teachar[:email_cell]
  $user_email_cell = "info@spa.fsr.jp"
  $user_email_cell = @teachar3[0].email_pc if @teachar3[0]
  $user_email_cell = @teachar3[0].email_pc + "," + @teachar3[1].email_pc if @teachar3[1]
  $user_email_cell = @teachar3[0].email_pc + "," + @teachar3[1].email_pc + "," + @teachar3[2].email_pc if @teachar3[2]

    @review_comment = ReviewComment.find(params[:id]) if @review_comment == nil

    Mailer.deliver_notice_to_comment_checker(@review_comment)
#    flash[:message] = _('mail was sent')
#    redirect_to :action => :show_spot, :id => @spot
  end

  def set_status_list
    @status_list = { 0 => _('working'),
                     1 => _('submited'),
                     2 => _('reviewing'),
                     3 => _('published'),
                     4 => _('holding') }
  end


end
