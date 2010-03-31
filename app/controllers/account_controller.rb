require 'digest/sha1'

class AccountController < ApplicationController

#  layout  'scaffold'

# level_0: full function

  before_filter(:chk_user_level_0, :only => [:delete,
                                             :edit_group,
                                             :destroy_group ])

  before_filter(:chk_user_level_2, :only => [:edit_user_by_l2,
                                             :destroy_user_l2 ])

  before_filter(:chk_user_level_3, :only => [:edit_user_by_l3,
                                             :destroy_user_by_l3 ])

  def index
    login
    render :action => 'login'
  end



  def new_group
    @group = Group.new
    @items = Item.find(:all)
  end

  def new_user
    user_new
  end

  def new_user_by_l2
    user_new
  end

  def new_user_by_l3
    user_new
  end
  
  def create_group
    @group = Group.new(params[:group])
    if @group.save
      flash['notice']  = _("Group was successfully created")
      redirect_to(:action => "list_group")
    else
      render(:action => 'new_group')
    end
  end

  def create_user
    set_user
    if @user.save
      flash['notice']  = _("User was successfully created")
      redirect_to(:action => 'list_user', :id => @user.group)
    else
      @groups = Group.find(:all)
      render(:action => 'new_user')
    end
  end

  def create_user_by_l2
    set_user
    if @user.save
      flash['notice']  = _("User was successfully created")
      redirect_to(:action => 'list_user_by_l2', :id => @user.group)
    else
      @groups = Group.find(:all)
      render(:action => 'new_user_by_l2')
    end
  end

  def create_user_by_l3
    set_user
    if @user.save
      flash['notice']  = _("User was successfully created")
      redirect_to(:action => 'list_user_by_l3', :id => @user.group)
    else
      @groups = Group.find(:all)
      render(:action => 'new_user_by_l3')
    end
  end

  def signup_user
    case request.method
      when :post
        params['user']['group_id'] = 4
        params['user']['level'] = 3
        @user = User.new(params['user'])
        
        if @user.save      
          @message = _('Signup successful, please login by new userid and password')
           render(:action => 'login', :controller => 'account')

        end
    end      
  end  



  def list_group
    get_groups
  end

  def list_group_by_l2
    get_groups
  end

  def list_group_by_l3
    get_groups
  end


  def list_user
    get_group_users
  end

  def list_user_by_l2
    get_group_users
  end

  def list_user_by_l3
    get_group_users
  end


  def edit_group
    @group = Group.find(params[:id])
  end

  def edit_group_by_l2
    @group = Group.find(params[:id])
  end

  def edit_group_by_l3
    @group = Group.find(params[:id])
  end

  def edit_user
    @user = User.find(params[:id])
    @groups = Group.find(:all)
  end

  def edit_user_by_l2
    @user = User.find(params[:id])
    @groups = Group.find(:all)
  end

  def edit_user_by_l3
    @user = User.find(params[:id])
    @groups = Group.find(:all)
  end

  def edit_user_by_user
#    @user = User.find(params[:id])
    @user = User.find(session[:user].id)
    @groups = Group.find(:all)
  end


  def update_group
    @group = Group.find(params[:id])
    if @group.update_attributes(params[:group])
      flash[:notice] = _('Group was successfully updated.')
      redirect_to(:action => 'list_group')
    else
      render(:action => 'edit_group')
    end
  end

  def update_group_by_l2
    @group = Group.find(params[:id])
    if @group.update_attributes(params[:group])
      flash[:notice] = _('Group was successfully updated.')
      redirect_to(:action => 'list_group_by_l2')
    else
      render(:action => 'edit_group_by_l2')
    end
  end

  def update_group_by_l3
    @group = Group.find(params[:id])
    if @group.update_attributes(params[:group])
      flash[:notice] = _('Group was successfully updated.')
      redirect_to(:action => 'list_group_by_l3')
    else
      render(:action => 'edit_group_by_l3')
    end
  end

  def update_user
    @user = User.find(params[:id])
    set_params_password
    if @user.update_attributes(params[:user])
      flash[:notice] = _('User was successfully updated.')
      redirect_to(:action => 'list_user', :id => @user.group_id)
    else
      @groups = Group.find(:all)
      render(:action => 'edit_user')
    end
  end

  def update_user_by_l2
    @user = User.find(params[:id])
    set_params_password
    if @user.update_attributes(params[:user])
      flash[:notice] = _('User was successfully updated.')
      redirect_to(:action => 'list_user_by_l2', :id => @user.group_id)
    else
      @groups = Group.find(:all)
      render(:action => 'edit_user_by_l2')
    end
  end

  def update_user_by_l3
    @user = User.find(params[:id])
    set_params_password
    if @user.update_attributes(params[:user])
      flash[:notice] = _('User was successfully updated.')
      redirect_to(:action => 'list_user_by_l3', :id => @user.group_id)
    else
      @groups = Group.find(:all)
      render(:action => 'edit_user_by_l3')
    end
  end

  def update_user_by_user
    @user = User.find(session[:user].id)
    set_params_password
    if @user.update_attributes(params[:user])
      flash[:message] = _('User was successfully updated.')
      redirect_to(:action => 'list_user', :id => @user.group_id )
#      redirect_to(:action => 'list', :controller => 'item' )
    else
      render(:action => 'edit_user_by_user')
#      redirect_to(:action => 'list', :controller => 'item' )
    end
  end


  def destroy_group
    Group.find(params[:id]).destroy
    redirect_to(:action => 'list_group')
  end

  def destroy_user
    user_destroy
    redirect_to(:action => 'list_user', :id => @group_id )
  end

  def destroy_user_by_l2
    user_destroy
    redirect_to(:action => 'list_user_by_l2', :id => @group_id )
  end

  def destroy_user_by_l3
    user_destroy
    redirect_to(:action => 'list_user_by_l3', :id => @group_id )
  end

  def login
    case request.method
      when :post
        if session[:user] = User.authenticate(params[:user][:login], params[:user][:password])
           flash[:notice] = _('Login complete')
          redirect_to(:controller => 'account', :action => 'welcome')
        else
          @login    = params[:user][:login]
          flash[:notice] = _('login unsuccessful')
        end
      end

  end

#  def login
#    case request.method
#      when :post      
#        if session['user'] = User.authenticate(@params['user_login'], @params['user_password'])
#          flash['notice']  = "Login successful"
#          redirect_back_or_default :action => "welcome"
#        else
#          @login    = @params['user_login']
#          @message  = "Login unsuccessful"
#      end
#    end
#  end



#  def login_old
#    case request.method
#      when :post      
##        if session[:user] = User.authenticate(params[:user][:login], params[:user][:password])
#
#        if session['user'] = User.authenticate(@params['user_login'], @params['user_password'])
#          flash['notice']  = "Login successful"
#          redirect_back_or_default :action => "welcome"
#        else
#          @login    = @params['user_login']
#          @message  = "Login unsuccessful"
#      end
#    end
#  end
  
  def signup
    case request.method
      when :post
        @user = User.new(params['user'])
        
        if @user.save      
          session['user'] = User.authenticate(@user.login, params['user']['password'])
          flash['notice']  = _("Signup successful")
          redirect_back_or_default :action => "welcome"          
        end
    end      
  end  
  
  def delete
    if params['id'] and session['user']
      @user = User.find(params['id'])
      @user.destroy
    end
    redirect_back_or_default :action => "welcome"
  end  
    
  def logout
    session[:user] = nil
    flash[:notice] = _('Logged out of the system')

  #  p flash

    redirect_to "/index.html"
  end
    
  def welcome

    @user = User.find(session[:user].id, :include => :student)

  end

  private
  
  def get_groups
    if session[:user][:level] == 2 or session[:user][:level] == 3
      @groups = Group.paginate(:page => params[:page], :per_page => 50, :conditions => ['id = ?', session[:user].group_id])
    else
    @groups = Group.paginate(:page => params[:page], :per_page => 50)
    end
  end

  def chk_user_level_0
    unless session[:user][:level] == 0
      flash[:notice] = _('user level too low !!')
      redirect_to(:action => 'list_group')
    end
  end  

  def chk_user_level_2
    unless session[:user][:level] <= 2
      flash[:notice] = _('user level too low !!')
      redirect_to(:action => 'list_group')
    end
  end

  def chk_user_level_3
    unless session[:user][:level] <= 3
      flash[:notice] = _('user level too low !!')
      redirect_to(:action => 'list_group')
    end
  end

  def level_list
    @level_list =  { 0 => _('admin_level'),
                     1 => _('level_1'),
                     2 => _('rw_member_level'),
                     3 => _('teachar_level'),
                     4 => _('level_4'),
                     5 => _('student_level') }
  end

  def get_group_users
   level_list
    @group = Group.find(params[:id])
#    @user_pages, @users = paginate(:users,
#                        :conditions => ['group_id = ?', @group.id])
    @users = User.paginate(:page => params[:page], :per_page => 50, :conditions => ['group_id = ?', @group.id])
  end

  def set_params_password
    params[:user][:password] = @user.password
    params[:user][:password] = Digest::SHA1.hexdigest("change-me--#{params[:password]}--") if params[:password] != ""
    params[:user][:password_confirmation] = Digest::SHA1.hexdigest("change-me--#{params[:password_confirmation]}--") if params[:password_confirmation] != ""
  end

  def set_user
    @user = User.new(params[:user])
    @user.group_id = session[:user].group_id if session[:user].level == 2 or session[:user].level == 3
    @user.password = params[:password] if params[:password] != ""
    @user.password_confirmation = params[:password_confirmation] if params[:password_confirmation] != ""
  end

  def user_new
    @user = User.new
    @user.group_id = session[:user].group.id if session[:user].level == 2 or session[:user].level == 3
    @groups = Group.find(:all)
  end

  def user_destroy
    user = User.find(params[:id])
    @group_id = user.group_id
    user.destroy
  end

end
