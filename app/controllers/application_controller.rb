#require 'gettext/rails'
#require 'login_engine'
# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
#require_dependency 'login_system'

class ApplicationController < ActionController::Base
 init_gettext 'otaku'
  # Pick a unique cookie name to distinguish our session data from others'
#  include LoginEngine
#  before_filter :login_required, :except =>[:list, :show, :image, :show_spot]
#  include LoginSystem
  layout 'application', :except => [ :xml_export_item,
                                     :xml_export_spot,
                                     :xml_export_category,
                                     :xml_export_structure,
                                     :xml_export_facility,
                                     :xml_export_particular,
                                     :xml_export_shopitem,
                                     :xml_export_shop
                                   ]

#  before_filter :login_required, :except => [:login, :signup, :list, :show, :image, :show_spot, :by_map]
#  before_filter :login_required, :except => [:login, :signup, :image, :by_map]

  before_filter :authorize, :except => [
                                             :tag,
                                             :login,
                                             :signup,
                                             :signup_user,
                                             :logout,
                                             :list,
                                             :list_m1y,
                                             :list_m6m,
                                             :list_m3m,
                                             :list_m1m,
                                             :list_m1w,
                                             :list_today,
                                             :list_p1w,
                                             :list_p1m,
                                             :list_p3m,
                                             :list_p6m,
                                             :list_p1y,
                                             :list_all,
                                             :list_grade_k_1,
                                             :list_grade_1,
                                             :list_grade_2_3,
                                             :list_grade_3,
                                             :list_grade_4_6,
                                             :list_grade_5,
                                             :list_grade_6,
                                             :list_grade_7_9,
                                             :list_grade_8,
                                             :list_grade_9,
                                             :list_grade_10_12,
                                             :list_grade_11,
                                             :list_grade_12,
                                             :list_grade_13_16,
                                             :list_grade_14,
                                             :list_grade_15,
                                             :list_grade_16,
                                             :list_grade_17,
                                             :list_grade_t,
                                             :list_author_grade_k_1,
                                             :list_author_grade_1,
                                             :list_author_grade_2_3,
                                             :list_author_grade_3,
                                             :list_author_grade_4_6,
                                             :list_author_grade_5,
                                             :list_author_grade_6,
                                             :list_author_grade_7_9,
                                             :list_author_grade_8,
                                             :list_author_grade_9,
                                             :list_author_grade_10_12,
                                             :list_author_grade_11,
                                             :list_author_grade_12,
                                             :list_author_grade_13_16,
                                             :list_author_grade_14,
                                             :list_author_grade_15,
                                             :list_author_grade_16,
                                             :list_author_grade_17,
                                             :list_author_grade_t,
                                             :list_by_author,
                                             :list_item,
                                             :list_shop,
                                             :list_recommend,
                                             :index,
                                             :index_by_map,
                                             :new,
                                             :new_spot,
                                             :new_shop_ind,
                                             :create_shopitem_from_item,
                                             :edit_by_l2,
                                             :update,
                                             :zip,
                                             :geocoding,
                                             :create,
                                             :create_spot,
                                             :create_shop_ind,
                                             :search_remote,
                                             :load_content_remote,
                                             :load_content_bak_remote,
                                       #      :sum_list,
                                             :show,
                                             :image,
                                             :show_spot,
                                             :show_spot_map,
                                             :by_map,
                                             :show_shop,
                                             :show_shop_map,
                                       #      :index,
                                       #      :create_article,
                                       #      :list_user,
                                       #      :list_group,
                                       #      :new_user,
                                       #      :new_group,
                                       #      :new_group,
                                       #      :create_user,
                                       #      :create_group,
                                       #      :edit_user,
                                       #      :edit_group,
                                       #      :update_user,
                                       #      :update_group,
                                             :welcome ]

  before_filter :find_tables, :except => [ 
                                           #   :welcome
                                         ]

  
  def authorize
    unless session[:user]
      flash.now['notice'] = _('Login unsuccessful')
      redirect_to(:controller => 'account', :action => 'login')
    end
  end

  def find_tables
    @categories = Category.find(:all, :order => 'name')
    @ensens = Item.find_by_sql("SELECT str_val_4 FROM `items` GROUP BY str_val_4")
    @facilities = Facility.find(:all, :order => 'facilities.seq', :include => [:facilitycat]) #, :conditions => ["facilities.seq = ?", '07'])
    @particulars = Particular.find(:all, :order => 'particulars.seq', :include => [:particularcat]) #, :conditions => ["particulars.seq = ?", '07'])
  end


#  session :session_key => '_spot_session_id'
end
