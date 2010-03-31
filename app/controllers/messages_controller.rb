class MessagesController < ApplicationController

  before_filter :authorize, :except => [
                                         :list,
                                         :show,
                                         :disp_mail_form1,
                                         :disp_mail_form2,
                                         :send_mail_form1,
                                         :send_mail_form2
                                       ]
  def authorize
    unless session[:user]
      flash.now['notice'] = _('Login unsuccessful')
      redirect_to(:controller => 'account', :action => 'login')
    end
  end



# level_0: full function
  before_filter(:chk_user_level_0, :only => [:new,
                                             :destroy,
                                             :edit,
                                            ])



  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    set_level
#    @message_pages, @messages = paginate :messages, :order => 'priority ASC', :per_page => 20
    if session[:user]
      if session[:user][:level] == 0
        @messages = Message.paginate(:page => params[:page], :order => 'level, priority ASC', :per_page => 50)
      end
      if session[:user][:level] == 3
        @messages = Message.paginate(:page => params[:page], :conditions => [ "level >= ?", 3 ],:order => 'level, priority ASC', :per_page => 50)
      end
      if session[:user][:level] == 5
        @messages = Message.paginate(:page => params[:page], :conditions => [ "level >= ?", 5 ],:order => 'level, priority ASC', :per_page => 50)
      end
    else
      @messages = Message.paginate(:page => params[:page], :conditions => [ "level >= ?", 9 ], :order => 'level, priority ASC', :per_page => 50)
    end
  end

  def show
    @message = Message.find(params[:id])
  end

  def new
#    chk_user_level_0
    @message = Message.new
  end

  def create
    @message = Message.new(params[:message])
    if @message.save
      flash[:notice] = _('Message was successfully created.')
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
#    chk_user_level_0
    @message = Message.find(params[:id])
  end

  def update
    @message = Message.find(params[:id])
    if @message.update_attributes(params[:message])
      flash[:notice] = _('Message was successfully updated.')
      redirect_to :action => 'show', :id => @message
    else
      render :action => 'edit'
    end
  end

  def destroy
#    chk_user_level_0
#    if chk_user_level_0
      Message.find(params[:id]).destroy
      flash[:notice] = _('Message was successfully deleted.')
      redirect_to :action => 'list'
#    end
  end

  def disp_mail_form1
  end

  def disp_mail_form2
  end

  def send_mail_form1
    @mail_form1 = params[:mail_form1]
    send_mail_form1_to_admin
    flash[:notice] = _('Mail was sent.')
    redirect_to :action => 'disp_mail_form1'
  end

  def send_mail_form2
    @mail_form2 = params[:mail_form2]
    send_mail_form2_to_admin
    flash[:notice] = _('Mail was sent.')
    redirect_to :action => 'disp_mail_form2'
  end

  private

   def send_mail_form1_to_admin

  #  @teachar1 = User.find(:first, :conditions => ["group_id = ? and level = 3", session[:user].group_id]).email_pc
  #  @teachar2 = User.find(:second, :conditions => ["group_id = ? and level = 3", session[:user].group_id]).email_pc
    @admin = User.find_by_sql("SELECT email_pc from users WHERE level = 0")
    #p @admin[:email_pc]
  $admin_email_pc = "info@spa.fsr.jp"
  $admin_email_pc = @admin[0].email_pc if @admin[0]
  $admin_email_pc = @admin[0].email_pc + "," + @admin[1].email_pc if @admin[1]
  $admin_email_pc = @admin[0].email_pc + "," + @admin[1].email_pc + "," + @admin[2].email_pc if @admin[2]

     p @mail_form1

    Mailer.deliver_send_mail_form1_to_admin(@mail_form1)
#    flash[:message] = _('mail was sent')
#    redirect_to :action => :show_spot, :id => @spot
  end 

   def send_mail_form2_to_admin

  #  @teachar1 = User.find(:first, :conditions => ["group_id = ? and level = 3", session[:user].group_id]).email_pc
  #  @teachar2 = User.find(:second, :conditions => ["group_id = ? and level = 3", session[:user].group_id]).email_pc
    @admin = User.find_by_sql("SELECT email_pc from users WHERE level = 0")
    #p @admin[:email_pc]
  $admin_email_pc = "info@spa.fsr.jp"
  $admin_email_pc = @admin[0].email_pc if @admin[0]
  $admin_email_pc = @admin[0].email_pc + "," + @admin[1].email_pc if @admin[1]
  $admin_email_pc = @admin[0].email_pc + "," + @admin[1].email_pc + "," + @admin[2].email_pc if @admin[2]

    Mailer.deliver_send_mail_form2_to_admin(@mail_form2)
#    flash[:message] = _('mail was sent')
#    redirect_to :action => :show_spot, :id => @spot
  end

  def chk_user_level_0
    unless session[:user][:level] == 0
      flash[:notice] = _('user level too low !!')
      redirect_to(:action => 'list')
    end
  end  


  def set_level
    @level_list =  { 0 => _('admin'),
                     3 => _('teachar'),
                     5 => _('student'),
                     9 => _('guest') }
  end

end
