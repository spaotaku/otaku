require 'csis_geocoding'

class ItemController < ApplicationController

#  layout 'applications', :except => :spreadsheet


  def xml_export_item
    @items = Item.find(:all, :order => 'created_at DESC',
                             :include => [:spot, :user, :category, :shop, :structure])
    response.headers['Content-Type'] = 'application/vnd.ms-excel'
    response.headers['Content-Disposition'] = 'attachment; filename="items.xml"'
  end

  def list

#    @torihiki_taiyou =  {Item::TORIHIKI_TAIYOU[0][1] => Item::TORIHIKI_TAIYOU[0][0],
#                         Item::TORIHIKI_TAIYOU[1][1] => Item::TORIHIKI_TAIYOU[1][0],
#                         Item::TORIHIKI_TAIYOU[2][1] => Item::TORIHIKI_TAIYOU[2][0],
#                         Item::TORIHIKI_TAIYOU[3][1] => Item::TORIHIKI_TAIYOU[3][0],
#                         Item::TORIHIKI_TAIYOU[4][1] => Item::TORIHIKI_TAIYOU[4][0]}

#    @torihiki_taiyou =  { 1 => _('baikai'),
#                          2 => _('kasinusi'),
#                          3 => _('urinusi'),
#                          4 => _('dairi'),
#                          9 => _('other') }

    set_torihiki_taiyou
    set_grade_list

    @facilities = Facility.find(:all, :include => [:facilitycat], :order => 'facilities.seq' )
    @facilityhash = Hash.new
    @facilitycathash = Hash.new
    for facility in @facilities
     @facilityhash[ facility.seq ] = facility.name
     @facilitycathash[ facility.seq ] = facility.facilitycat.name
    end

    @particulars = Particular.find(:all, :include => [:particularcat], :order => 'particulars.seq' )
    @particularhash = Hash.new
    @particularcathash = Hash.new
    for particular in @particulars
     @particularhash[ particular.seq ] = particular.name
     @particularcathash[ particular.seq ] = particular.particularcat.name
    end

    
    conditions = nil
#    if keyword = params[:keyword]
#      keyword = "%" + keyword + "%"
##      conditions = ["(name like ?)"]
##      conditions = ["spots.name like ?"]
#      conditions = ["(items.name like ? or spots.name like ?) and
#                     (items.user_id = ? or items.publish_level = ? or ( items.publish_level = ? and users.group_id = ? ))"]
#      conditions << keyword
#      conditions << keyword
#      conditions << session[:user].id
#      conditions << 9
#      conditions << 5
#      conditions << session[:user].group_id
#    else
#      conditions = "items.user_id = ? or
#                    items.publish_level = ? or
#                    ( items.publish_level = ? and users.group_id = ? ) ",
#                    session[:user].id,
#                    9,
#                    5,
#                    session[:user].group_id
#    end  

    if keyword = params[:keyword]
      keyword = "%" + keyword + "%"
#      conditions = ["(name like ?)"]
#      conditions = ["spots.name like ?"]
      if session[:user]
        conditions = ["items.name like ? or spots.name like ?"]
        conditions << keyword
        conditions << keyword
      else
        conditions = ["(items.name like ? or spots.name like ?) and
                       items.publish_level like ? "]
        conditions << keyword
        conditions << keyword
        conditions << 9
      end
    else
      if session[:user]
        conditions = nil
      else
        conditions = "items.publish_level = ?",
                      9
      end
    end  

#    @page, @items = paginate :items, :order => 'created_at DESC', :per_page => 5,
#                             :conditions => conditions, :include => [:spot, :user, :category, :shop]
    @items = Item.paginate(:page => params[:page], :order => 'created_at DESC', :per_page => 5,
                             :conditions => conditions, :include => [:spot, :user, :category, :shop])


  end

  def index
    
#      options = [[ _("select_torihiki_taiyou"), ""]] + Item::TORIHIKI_TAIYOU
    
    @categories = Category.find(:all, :order => 'name')
    
    @ensens = Item.find_by_sql("SELECT str_val_4 FROM `items` GROUP BY str_val_4")
#    p options_from_collection_for_select(@categories, "id", "name")
    
#    @torihiki_taiyou =  {Item::TORIHIKI_TAIYOU[0][1] => Item::TORIHIKI_TAIYOU[0][0],
#                         Item::TORIHIKI_TAIYOU[1][1] => Item::TORIHIKI_TAIYOU[1][0],
#                         Item::TORIHIKI_TAIYOU[2][1] => Item::TORIHIKI_TAIYOU[2][0]}
    set_torihiki_taiyou
    
    @facilities = Facility.find(:all, :include => [:facilitycat], :order => 'facilities.seq' )
    @facilityhash = Hash.new
    @facilitycathash = Hash.new
    for facility in @facilities
     @facilityhash[ facility.seq ] = facility.name
     @facilitycathash[ facility.seq ] = facility.facilitycat.name
    end

    @particulars = Particular.find(:all, :include => [:particularcat], :order => 'particulars.seq' )
    @particularhash = Hash.new
    @particularcathash = Hash.new
    for particular in @particulars
     @particularhash[ particular.seq ] = particular.name
     @particularcathash[ particular.seq ] = particular.particularcat.name
    end

    @items = []
      
      conditions = []

      if keyword_name = params[:keyword_name] and keyword_name != ""
         keyword_name = "%" + keyword_name + "%"
         conditions << "items.name like #{Item.quote_value(keyword_name)}"
      end
      if keyword_address = params[:keyword_address] and keyword_address != ""
         keyword_address = "%" + keyword_address + "%"
         conditions << "spots.address like #{Item.quote_value(keyword_address)}"
      end
      if category = params[:category] and category != "0"
         conditions << "items.category_id = #{Item.quote_value(category)}"
      end
      if ensen = params[:ensen] and ensen != ""
         conditions << "items.str_val_4 = #{Item.quote_value(ensen)}"
      end
      if keyword_kakaku = params[:keyword_kakaku] and keyword_kakaku != ""
         conditions << "items.num_val_p <= #{Item.quote_value(keyword_kakaku)}"
      end
      if keyword_tinryou = params[:keyword_tinryou] and keyword_tinryou != ""
         conditions << "items.num_val_1 <= #{Item.quote_value(keyword_tinryou)}"
      end
      sql = "SELECT * FROM spots "
      sql << "RIGHT OUTER JOIN items ON spots.id = items.spot_id "
      unless conditions.empty?
        sql << %Q|WHERE (#{conditions.join(") AND (")})|
      end
      
        sql << " ORDER BY created_at DESC"
      
      @items = Item.find_by_sql(sql)




  end

  def index_by_map
    
#      options = [[ _("select_torihiki_taiyou"), ""]] + Item::TORIHIKI_TAIYOU
    
    @categories = Category.find(:all, :order => 'name')
    
    @ensens = Item.find_by_sql("SELECT str_val_4 FROM `items` GROUP BY str_val_4")
#    p options_from_collection_for_select(@categories, "id", "name")

    set_torihiki_taiyou
    
    @facilities = Facility.find(:all, :include => [:facilitycat], :order => 'facilities.seq' )
    @facilityhash = Hash.new
    @facilitycathash = Hash.new
    for facility in @facilities
     @facilityhash[ facility.seq ] = facility.name
     @facilitycathash[ facility.seq ] = facility.facilitycat.name
    end

    @particulars = Particular.find(:all, :include => [:particularcat], :order => 'particulars.seq' )
    @particularhash = Hash.new
    @particularcathash = Hash.new
    for particular in @particulars
     @particularhash[ particular.seq ] = particular.name
     @particularcathash[ particular.seq ] = particular.particularcat.name
    end

    @items = []

      conditions = []

      if keyword_name = params[:keyword_name] and keyword_name != ""
         keyword_name = "%" + keyword_name + "%"
         conditions << "items.name like #{Item.quote_value(keyword_name)}"
      end
      if keyword_address = params[:keyword_address] and keyword_address != ""
         keyword_address = "%" + keyword_address + "%"
         conditions << "spots.address like #{Item.quote_value(keyword_address)}"
      end
      if category = params[:category] and category != "0"
         conditions << "items.category_id = #{Item.quote_value(category)}"
      end
      if ensen = params[:ensen] and ensen != ""
         conditions << "items.str_val_4 = #{Item.quote_value(ensen)}"
      end
      if keyword_kakaku = params[:keyword_kakaku] and keyword_kakaku != ""
         conditions << "items.num_val_p <= #{Item.quote_value(keyword_kakaku)}"
      end
      if keyword_tinryou = params[:keyword_tinryou] and keyword_tinryou != ""
         conditions << "items.num_val_1 <= #{Item.quote_value(keyword_tinryou)}"
      end
      sql = "SELECT * FROM spots "
      sql << "RIGHT OUTER JOIN items ON spots.id = items.spot_id "
      unless conditions.empty?
        sql << %Q|WHERE (#{conditions.join(") AND (")})|
      end

        sql << " ORDER BY created_at DESC"

      @items = Item.find_by_sql(sql).paginate(:page => params[:page], :conditions => conditions, :per_page => 1000, :include => ['spot'])

  end

  def search_remote
#    @torihiki_taiyou =  {Item::TORIHIKI_TAIYOU[0][1] => Item::TORIHIKI_TAIYOU[0][0],
#                         Item::TORIHIKI_TAIYOU[1][1] => Item::TORIHIKI_TAIYOU[1][0],
#                         Item::TORIHIKI_TAIYOU[2][1] => Item::TORIHIKI_TAIYOU[2][0]}
    set_torihiki_taiyou
    
    @facilities = Facility.find(:all, :include => [:facilitycat], :order => 'facilities.seq' )
    @facilityhash = Hash.new
    @facilitycathash = Hash.new
    for facility in @facilities
     @facilityhash[ facility.seq ] = facility.name
     @facilitycathash[ facility.seq ] = facility.facilitycat.name
    end

    @particulars = Particular.find(:all, :include => [:particularcat], :order => 'particulars.seq' )
    @particularhash = Hash.new
    @particularcathash = Hash.new
    for particular in @particulars
     @particularhash[ particular.seq ] = particular.name
     @particularcathash[ particular.seq ] = particular.particularcat.name
    end

    conditions = nil
#    if keyword = params[:keyword]
#      keyword = "%" + keyword + "%"
##      conditions = ["(name like ?)"]
##      conditions = ["spots.name like ?"]
#      conditions = ["(items.name like ? or spots.name like ?) and
#                     (items.user_id = ? or items.publish_level = ? or ( items.publish_level = ? and users.group_id = ? ))"]
#      conditions << keyword
#      conditions << keyword
#      conditions << session[:user].id
#      conditions << 9
#      conditions << 5
#      conditions << session[:user].group_id
#    else
#      conditions = "items.user_id = ? or
#                    items.publish_level = ? or
#                    ( items.publish_level = ? and users.group_id = ? ) ",
#                    session[:user].id,
#                    9,
#                    5,
#                    session[:user].group_id
#    end  


    @items = []


    if keyword = params[:keyword] and category = params[:category]
      keyword = "%" + keyword + "%"
#      conditions = ["(name like ?)"]
#      conditions = ["spots.name like ?"]
      if session[:user]
        conditions = ["(items.name like ? or spots.name like ?) and items.category_id = ?"]
        conditions << keyword
        conditions << keyword
        conditions << category
      else
        conditions = ["(items.name like ? or spots.name like ?) and
                       items.publish_level like ? "]
        conditions << keyword
        conditions << keyword
        conditions << 9
      end
      @items = Item.find(:all, :order => 'created_at DESC', 
                             :conditions => conditions, :include => [:spot, :user, :category, :shop])
    elsif keyword = params[:keyword] 
      keyword = "%" + keyword + "%"
#      conditions = ["(name like ?)"]
#      conditions = ["spots.name like ?"]
      if session[:user]
        conditions = ["items.name like ? or spots.name like ?"]
        conditions << keyword
        conditions << keyword
      else
        conditions = ["(items.name like ? or spots.name like ?) and
                       items.publish_level like ? "]
        conditions << keyword
        conditions << keyword
        conditions << 9
      end
      @items = Item.find(:all, :order => 'created_at DESC', 
                             :conditions => conditions, :include => [:spot, :user, :category, :shop])
      
    else
      if session[:user]
        conditions = nil
      else
        conditions = "items.publish_level = ?",
                      9
      end
      @items = Item.find(:all, :order => 'created_at DESC',
                             :conditions => conditions, :include => [:spot, :user, :category, :shop])

    end  

#    render(:partial => 'items')

#      @items = Item.find(:all, :order => 'created_at DESC',
#                             :conditions => conditions, :include => [:spot, :user, :category, :shop])
#    if category = params[:category]
#      @items = Item.find(:all, :order => 'created_at DESC',
#                             :conditions => ["items.category_id = ?", category ], :include => [:spot, :user, :category, :shop])
#    end


#    render :partial => 'posts'
     render :update do |page|
        page.replace_html 'main', render(:partial => 'items')
     end
#     render :update do |page|
##         page.remove "items"
#         page.replace_html 'items',
#         render(:partial => 'items')
#     end

#    @item = Item.find(params[:id])

#    render :update do |page|
#      page.hide "load_content_button_#{@item.id}"
#      page.replace_html "item_#{@item.id}",
#         render(:partial => 'item_content')
#    end

    
    
    
    
    
    
    
  end

  def load_content_remote

#    @torihiki_taiyou =  {Item::TORIHIKI_TAIYOU[0][1] => Item::TORIHIKI_TAIYOU[0][0],
#                         Item::TORIHIKI_TAIYOU[1][1] => Item::TORIHIKI_TAIYOU[1][0],
#                         Item::TORIHIKI_TAIYOU[2][1] => Item::TORIHIKI_TAIYOU[2][0]}

    set_torihiki_taiyou
    
    @facilities = Facility.find(:all, :include => [:facilitycat], :order => 'facilities.seq' )
    @facilityhash = Hash.new
    @facilitycathash = Hash.new
    for facility in @facilities
     @facilityhash[ facility.seq ] = facility.name
     @facilitycathash[ facility.seq ] = facility.facilitycat.name
    end

    @particulars = Particular.find(:all, :include => [:particularcat], :order => 'particulars.seq' )
    @particularhash = Hash.new
    @particularcathash = Hash.new
    for particular in @particulars
     @particularhash[ particular.seq ] = particular.name
     @particularcathash[ particular.seq ] = particular.particularcat.name
    end

    @item = Item.find(params[:id])
    render :update do |page|
      page.hide "load_content_button_#{@item.id}"
      page.replace_html "load_content_button_bak_#{@item.id}",
        render(:partial => 'back_content')
#      page.replace_html "load_content_button_bak_#{@item.id}"
#         render(:partial => 'back_content')
      page.replace_html "item_#{@item.id}",
        render(:partial => 'item_content')
      page.show "item_#{@item.id}"  
    end
  end

  def load_content_bak_remote
#    @torihiki_taiyou =  {Item::TORIHIKI_TAIYOU[0][1] => Item::TORIHIKI_TAIYOU[0][0],
#                         Item::TORIHIKI_TAIYOU[1][1] => Item::TORIHIKI_TAIYOU[1][0],
#                         Item::TORIHIKI_TAIYOU[2][1] => Item::TORIHIKI_TAIYOU[2][0]}

    set_torihiki_taiyou
    
    @facilities = Facility.find(:all, :include => [:facilitycat], :order => 'facilities.seq' )
    @facilityhash = Hash.new
    @facilitycathash = Hash.new
    for facility in @facilities
     @facilityhash[ facility.seq ] = facility.name
     @facilitycathash[ facility.seq ] = facility.facilitycat.name
    end

    @particulars = Particular.find(:all, :include => [:particularcat], :order => 'particulars.seq' )
    @particularhash = Hash.new
    @particularcathash = Hash.new
    for particular in @particulars
     @particularhash[ particular.seq ] = particular.name
     @particularcathash[ particular.seq ] = particular.particularcat.name
    end

    @item = Item.find(params[:id])
    render :update do |page|
      page.hide "item_#{@item.id}"
#      page.hide "load_content_button_#{@item.id}"
      page.replace_html "load_content_button_bak_#{@item.id}",
        render(:partial => 'back_content_reset')
    end
  end


  def list_item
    conditions = nil
    if keyword = params[:keyword]
      keyword = "%" + keyword + "%"
      if session[:user]
        conditions = ["items.name like ? or spots.name like ?"]
        conditions << keyword
        conditions << keyword
      else
        conditions = ["(items.name like ? or spots.name like ?) and
                       items.publish_level like ? "]
        conditions << keyword
        conditions << keyword
        conditions << 9
      end
    else
      if session[:user]
        conditions = nil
      else
        conditions = "items.publish_level = ?",
                      9
      end
    end  

#    @page, @items = paginate :items, :order => 'created_at DESC', :per_page => 5,
#                             :conditions => conditions, :include => [:spot, :user, :category, :shop]

#    @item_pages, @items = paginate(:items, :per_page => 20,
    @items = Item.paginate(:page => params[:page], :per_page => 50,
      :conditions => conditions, :include => [:spot, :user, :category, :shop] )
  end



  def new
    @facilities = Facility.find(:all, :order => 'facilities.seq', :include => [:facilitycat]) #, :conditions => ["facilities.seq = ?", '07'])
    @particulars = Particular.find(:all, :order => 'particulars.seq', :include => [:particularcat]) #, :conditions => ["particulars.seq = ?", '07'])

  end

  def new_spot
    render :partial => 'spot_form'
  end

  def create
    begin 
      create_spot
      create_item
    rescue
      log_error($!)
      render :action => :new
      return
    end
    flash[:message] = _('new item successfully created')
    redirect_to :action => :list
  end

  def zip
#    @prefecture, @address1, @address2 = Spot.zip2address(params[:zip])
#    @prefecture, @address1 = Spot.zip2address(params[:zip])
    @prefecture = Spot.zip2address(params[:zip])
  end


  def geocoding
    @candidates = CSIS::Geocoding.new(params[:spot][:address], params[:series]).candidates
    render :partial => 'address_option'
  end

  def by_map

#    conditions = nil
#    conditions = "spots.user_id = ? or
#                  users.group_id = ? ",
#                  session[:user].id,
#                  session[:user].group_id
#    @page, @spots = paginate :spots, :per_page => 100,
#                             :conditions => conditions, :include => :user

#if session[:user]
#    conditions = nil
#    conditions = "spots.user_id = ? or
#                ( spots.group_id = ? and spots.publish_level = ? ) or
#                  spots.publish_level = ? ",
#                  session[:user].id,
#                  session[:user].group_id,
#                  5,
#                  9
#                  
#    @page, @spots = paginate :spots, :per_page => 100,
#                             :conditions => conditions, :include => :user
#else
#    conditions = nil
#    conditions = "spots.publish_level = ? ",
#                  9
#    @page, @spots = paginate :spots, :per_page => 100,
#                             :conditions => conditions

    @categories = Category.find(:all, :order => 'name')
    
    @ensens = Item.find_by_sql("SELECT str_val_4 FROM `items` GROUP BY str_val_4")
#    p options_from_collection_for_select(@categories, "id", "name")
    
#    @torihiki_taiyou =  {Item::TORIHIKI_TAIYOU[0][1] => Item::TORIHIKI_TAIYOU[0][0],
#                         Item::TORIHIKI_TAIYOU[1][1] => Item::TORIHIKI_TAIYOU[1][0],
#                         Item::TORIHIKI_TAIYOU[2][1] => Item::TORIHIKI_TAIYOU[2][0]}
    set_torihiki_taiyou
    
    @facilities = Facility.find(:all, :include => [:facilitycat], :order => 'facilities.seq' )
    @facilityhash = Hash.new
    @facilitycathash = Hash.new
    for facility in @facilities
     @facilityhash[ facility.seq ] = facility.name
     @facilitycathash[ facility.seq ] = facility.facilitycat.name
    end

    @particulars = Particular.find(:all, :include => [:particularcat], :order => 'particulars.seq' )
    @particularhash = Hash.new
    @particularcathash = Hash.new
    for particular in @particulars
     @particularhash[ particular.seq ] = particular.name
     @particularcathash[ particular.seq ] = particular.particularcat.name
    end

    
    
    #@page, @items = paginate :items, :conditions => ['spots.latitude is not null and spots.longitude is not null'],
    #               :per_page => 100, :include => ['spot']
    @items = Item.paginate(:page => params[:page], :conditions => ['spots.latitude is not null and spots.longitude is not null'],
                   :per_page => 1000, :include => ['spot'])
#    @items = Item.paginate(:page => params[:page], :conditions => ['spots.latitude is not null and spots.longitude is not null and spots.address like ?', '%羽田%' ],
#                   :per_page => 1000, :include => ['spot'])

#
#
#end
  end

  def create_spot
    if params[:spot]

      set_lat_lon_tokyo_datum_dec
      set_lat_lon_tokyo_datum_ddmmsss

      @spot = Spot.new(params[:spot])
      if session[:user]
        @spot.user_id = session[:user].id
        @spot.group_id = session[:user].group_id
      else
        @spot.user_id = 1
        @spot.group_id = 1
      end
      @spot.save!
      params[:item][:spot_id] = @spot.id
      @spot = nil
    end
  end


  def update_item

    if params[:item][:str_val_4] != ""
      params[:item][:str_val_3] = params[:item][:str_val_4]
      params[:item][:str_val_4] = nil
    end


#    params[:item][:created_at] = param_time()
    Item.transaction do
      unless @item.update_attributes(params[:item])
        raise 'failed to update'
      end
      save_pics
    end
  end


#  def save_pics
#    [:picture0, :picture1].each do |pic|
#      next if params[pic].nil? || params[pic][:file].length == 0
#      @picture = @item.pictures.build
#      @picture.file = params[pic][:file]
#      @picture.save!
#    end
#  end

  def delete_pics
    return unless params[:pic]
    params[:pic].each do |k,v|
      Picture.delete(k) if v == '1'
    end
  end

  def param_time()
    Time.local(params[:date][:year], 
	       params[:date][:month], 
	       params[:date][:day],
	       params[:date][:hour],
	       params[:date][:minute])
  end

  def create_item

    if params[:item][:str_val_4] != ""
      params[:item][:str_val_3] = params[:item][:str_val_4]
      params[:item][:str_val_4] = nil
    end
    


    Item.transaction do
      @item = Item.new(params[:item])
#      @item.created_at = param_time()
      if session[:user]
        @item.user_id = session[:user].id
        @item.group_id = session[:user].group_id
      else
        @item.user_id = 1
        @item.group_id = 1
      end
      p @item
      @item.save!
      save_pics
    end
  end
  
  def save_pics
    [:picture0, :picture1, :picture2, :picture3, :picture4].each do |pic|  
      next if params[pic].nil?
      next if params[pic][:file].nil?
      next if params[pic][:file].length == 0
      @picture = @item.pictures.build
      @picture.file = params[pic][:file]
      @picture.title = params[pic][:title]
      @picture.save!
    end
  end
    
  def show

#    @torihiki_taiyou =  {Item::TORIHIKI_TAIYOU[0][1] => Item::TORIHIKI_TAIYOU[0][0],
#    Item::TORIHIKI_TAIYOU[1][1] => Item::TORIHIKI_TAIYOU[1][0],
#    Item::TORIHIKI_TAIYOU[2][1] => Item::TORIHIKI_TAIYOU[2][0]}

    set_torihiki_taiyou
    set_grade_list

    @facilities = Facility.find(:all, :include => [:facilitycat]) #, :conditions => ["facilities.seq = ?", '07'])
    @facilityhash = Hash.new
    @facilitycathash = Hash.new
    for facility in @facilities
     @facilityhash[ facility.seq ] = facility.name
     @facilitycathash[ facility.seq ] = facility.facilitycat.name
    end

    @particulars = Particular.find(:all, :include => [:particularcat]) #, :conditions => ["particulars.seq = ?", '07'])
    @particularhash = Hash.new
    @particularcathash = Hash.new
    for particular in @particulars
     @particularhash[ particular.seq ] = particular.name
     @particularcathash[ particular.seq ] = particular.particularcat.name
    end

    @item = Item.find(params[:id], :include => [:category])
    @students = Student.find(:all, :conditions => ["students.item_id = ?", params[:id]])
  end

  def edit
    @facilities = Facility.find(:all, :order => 'facilities.seq', :include => [:facilitycat]) #, :conditions => ["facilities.seq = ?", '07'])
    @particulars = Particular.find(:all, :order => 'particulars.seq', :include => [:particularcat]) #, :conditions => ["particulars.seq = ?", '07'])
    @item = Item.find(params[:id])
    unless @item.user_id == session[:user].id
      flash[:message] = 'error user unmuch'
      redirect_to :action => :show, :id => @item
    end
  end

  def update
    
 #   @torihiki_taiyou =  {Item::TORIHIKI_TAIYOU[0][1] => Item::TORIHIKI_TAIYOU[0][0],
 #   Item::TORIHIKI_TAIYOU[1][1] => Item::TORIHIKI_TAIYOU[1][0],
 #   Item::TORIHIKI_TAIYOU[2][1] => Item::TORIHIKI_TAIYOU[2][0]}

    set_torihiki_taiyou
    
    @facilities = Facility.find(:all, :include => [:facilitycat]) #, :conditions => ["facilities.seq = ?", '07'])
    @facilityhash = Hash.new
    @facilitycathash = Hash.new
    for facility in @facilities
     @facilityhash[ facility.seq ] = facility.name
     @facilitycathash[ facility.seq ] = facility.facilitycat.name
    end

    @particulars = Particular.find(:all, :include => [:particularcat]) #, :conditions => ["particulars.seq = ?", '07'])
    @particularhash = Hash.new
    @particularcathash = Hash.new
    for particular in @particulars
     @particularhash[ particular.seq ] = particular.name
     @particularcathash[ particular.seq ] = particular.particularcat.name
    end

    
    @item = Item.find(params[:id])
    begin
      create_spot
      update_item
      delete_pics
    rescue
      log_error($!)
      render :action => :edit
      return
    end
    flash[:message] = _('item successfully updated')
    redirect_to :action => :show, :id => @item
  end

  def delete
#    @torihiki_taiyou =  {Item::TORIHIKI_TAIYOU[0][1] => Item::TORIHIKI_TAIYOU[0][0],
#    Item::TORIHIKI_TAIYOU[1][1] => Item::TORIHIKI_TAIYOU[1][0],
#    Item::TORIHIKI_TAIYOU[2][1] => Item::TORIHIKI_TAIYOU[2][0]}

    set_torihiki_taiyou

    @facilities = Facility.find(:all, :include => [:facilitycat]) #, :conditions => ["facilities.seq = ?", '07'])
    @facilityhash = Hash.new
    @facilitycathash = Hash.new
    for facility in @facilities
     @facilityhash[ facility.seq ] = facility.name
     @facilitycathash[ facility.seq ] = facility.facilitycat.name
    end

    @particulars = Particular.find(:all, :include => [:particularcat]) #, :conditions => ["particulars.seq = ?", '07'])
    @particularhash = Hash.new
    @particularcathash = Hash.new
    for particular in @particulars
     @particularhash[ particular.seq ] = particular.name
     @particularcathash[ particular.seq ] = particular.particularcat.name
    end

    @item = Item.find(params[:id])
  end

  def remove
    @item = Item.find(params[:id])
    @item.destroy
    flash[:message] = _('item successfully deleted')
    redirect_to :action => 'list'
  end
  
  def image
    pic = Picture::find(params[:id])
    unless pic
      redirect_to '/404.html' 
      return
    end
    response.headers["Content-Type"] = pic.content_type
    response.headers["Content-Disposition"] = "inline"
    render :text => pic.image
  end


  def list_spot
#    @page, @spots = paginate :spots, :per_page => 5
    @spots = Spot.paginate(:page => params[:page], :per_page => 5)
  end

  def xml_export_spot
    @spots = Spot.find(:all)
    response.headers['Content-Type'] = 'application/vnd.ms-excel'
    response.headers['Content-Disposition'] = 'attachment; filename="spots.xml"'
  end


  def show_spot
    
#    @torihiki_taiyou =  {Item::TORIHIKI_TAIYOU[0][1] => Item::TORIHIKI_TAIYOU[0][0],
#    Item::TORIHIKI_TAIYOU[1][1] => Item::TORIHIKI_TAIYOU[1][0],
#    Item::TORIHIKI_TAIYOU[2][1] => Item::TORIHIKI_TAIYOU[2][0]}

    set_torihiki_taiyou
    set_grade_list

    @facilities = Facility.find(:all, :include => [:facilitycat]) #, :conditions => ["facilities.seq = ?", '07'])
    @facilityhash = Hash.new
    @facilitycathash = Hash.new
    for facility in @facilities
     @facilityhash[ facility.seq ] = facility.name
     @facilitycathash[ facility.seq ] = facility.facilitycat.name
    end

    @particulars = Particular.find(:all, :include => [:particularcat]) #, :conditions => ["particulars.seq = ?", '07'])
    @particularhash = Hash.new
    @particularcathash = Hash.new
    for particular in @particulars
     @particularhash[ particular.seq ] = particular.name
     @particularcathash[ particular.seq ] = particular.particularcat.name
    end

    @spot = Spot.find(params[:id])

#      conditions = "items.user_id = ? or
#                    items.publish_level = ? or
#                    ( items.publish_level = ? and users.group_id = ? ) ",
#                    session[:user].id,
#                    9,
#                    5,
#                    session[:user].group_id


#    @page, @items = paginate :items,
    @items = Item.paginate(:page => params[:page],
      #      :conditions => ['spot_id = ? and (
#                                          items.user_id = ? or
#                                          items.publish_level = ? or
#                                         (items.publish_level = ? and users.group_id = ? )
#                                         ) ',
#                          @spot.id, session[:user].id, 9, 5, session[:user].group_id],
      :conditions => [ 'spot_id = ? and (
                                          items.publish_level = ? or
                                          items.publish_level = ? 
                                         ) ',
                          @spot.id, 9, 5 ],

      :per_page => 5, :order => 'created_at DESC', :include => [:user])
  end

  def show_spot_map
    @spot = Spot.find(params[:id])
  end

  def send_spot_map_by_mail
    $user_email_cell = session[:user].email_cell
    @spot = Spot.find(params[:id])
    Mailer.deliver_send_spot_map_by_mail(@spot)
    flash[:message] =  'mail was sent'
    redirect_to :action => :show_spot, :id => @spot
  end


  def edit_spot
    @spot = Spot.find(params[:id])
    unless @spot.user_id == session[:user].id
      flash[:message] = 'error user unmuch'
      redirect_to :action => :show_spot, :id => @spot
    end
  end

  
  def update_spot
    @spot = Spot.find(params[:id])
 
    set_lat_lon_tokyo_datum_dec
    set_lat_lon_tokyo_datum_ddmmsss

#    @spot.user_id = session[:user].id

    unless @spot.update_attributes(params[:spot])
      render :action => :edit_spot
    else
      flash[:message] = _('spot successfully updated')
      redirect_to url_for(:action => :show_spot, :id => @spot)
    end
  end


  def delete_spot
    
#    @torihiki_taiyou =  {Item::TORIHIKI_TAIYOU[0][1] => Item::TORIHIKI_TAIYOU[0][0],
#    Item::TORIHIKI_TAIYOU[1][1] => Item::TORIHIKI_TAIYOU[1][0],
#    Item::TORIHIKI_TAIYOU[2][1] => Item::TORIHIKI_TAIYOU[2][0]}

    set_torihiki_taiyou

    @facilities = Facility.find(:all, :include => [:facilitycat]) #, :conditions => ["facilities.seq = ?", '07'])
    @facilityhash = Hash.new
    @facilitycathash = Hash.new
    for facility in @facilities
     @facilityhash[ facility.seq ] = facility.name
     @facilitycathash[ facility.seq ] = facility.facilitycat.name
    end

    @particulars = Particular.find(:all, :include => [:particularcat]) #, :conditions => ["particulars.seq = ?", '07'])
    @particularhash = Hash.new
    @particularcathash = Hash.new
    for particular in @particulars
     @particularhash[ particular.seq ] = particular.name
     @particularcathash[ particular.seq ] = particular.particularcat.name
    end

    @spot = Spot.find(params[:id])

#      conditions = "items.user_id = ? or
#                    items.publish_level = ? or
#                    ( items.publish_level = ? and users.group_id = ? ) ",
#                    session[:user].id,
#                    9,
#                    5,
#                    session[:user].group_id


    @items = Item.paginate(:page => params[:page],
#      :conditions => ['spot_id = ? and (
#                                          items.user_id = ? or
#                                          items.publish_level = ? or
#                                         (items.publish_level = ? and users.group_id = ? )
#                                         ) ',
#                          @spot.id, session[:user].id, 9, 5, session[:user].group_id],
      :conditions => [ 'spot_id = ? and (
                                          items.publish_level = ? or
                                          items.publish_level = ? 
                                         ) ',
                          @spot.id, 9, 5 ],

      :per_page => 5, :order => 'created_at DESC', :include => [:user])

  end

  def remove_spot
    @spot = Spot.find(params[:id])
    @spot.destroy
    flash[:message] = _('spot successfully deleted')
    redirect_to :action => 'list_spot'
  end


  def list_category
    @categories = Category.paginate(:page => params[:page], :per_page => 30)
  end

  def xml_export_category
    @categories = Category.find(:all)
    response.headers['Content-Type'] = 'application/vnd.ms-excel'
    response.headers['Content-Disposition'] = 'attachment; filename="categories.xml"'
  end


  def new_category
    @category = Category.new
  end

  def create_category
    @category = Category.new(params[:category])
    if @category.save
      flash['notice']  = _("Category was successfully created")
      redirect_to(:action => "list_category")
    else
      render(:action => 'new_category')
    end
  end


  def show_category
    @category = Category.find(params[:id])
  end

  def edit_category
    @category = Category.find(params[:id])
  end

  
  def update_category
    @category = Category.find(params[:id])
    if @category.update_attributes(params[:category])
      flash[:notice] = _('Category was successfully updated.')
      redirect_to(:action => 'list_category')
    else
      render(:action => 'edit_category')
    end
  end

  def destroy_category
    Category.find(params[:id]).destroy
    redirect_to(:action => 'list_category')
  end

  def list_structure
    @structures = Structure.paginate(:page => params[:page], :per_page => 30)
  end

  def xml_export_structure
    @structures = Structure.find(:all)
    response.headers['Content-Type'] = 'application/vnd.ms-excel'
    response.headers['Content-Disposition'] = 'attachment; filename="structures.xml"'
  end


  def new_structure
    @structure = Structure.new
  end

  def create_structure
    @structure = Structure.new(params[:structure])
    if @structure.save
      flash['notice']  = _("Structure was successfully created")
      redirect_to(:action => "list_structure")
    else
      render(:action => 'new_structure')
    end
  end

  def show_structure
    @structure = Structure.find(params[:id])
  end

  def edit_structure
    @structure = Structure.find(params[:id])
  end
  
  def update_structure
    @structure = Structure.find(params[:id])
    if @structure.update_attributes(params[:structure])
      flash[:notice] = _('Structure was successfully updated.')
      redirect_to(:action => 'list_structure')
    else
      render(:action => 'edit_structure')
    end
  end

  def destroy_structure
    Structure.find(params[:id]).destroy
    redirect_to(:action => 'list_structure')
  end

  def list_facility
    #@facility_pages, @facilities = paginate(:facilities, :per_page => 100, :order => 'facilities.seq', :include => [:facilitycat])
    @facilities = Facility.paginate(:page => params[:page], :per_page => 100, :order => 'facilities.seq', :include => [:facilitycat])
  end

  def xml_export_facility
    @facilities = Facility.find(:all, :order => 'facilities.seq', :include => [:facilitycat])
    response.headers['Content-Type'] = 'application/vnd.ms-excel'
    response.headers['Content-Disposition'] = 'attachment; filename="facilities.xml"'
  end

  def new_facility
    @facility = Facility.new
  end

  def create_facility
    @facility = Facility.new(params[:facility])
    if @facility.save
      flash['notice']  = _("Facility was successfully created")
      redirect_to(:action => "list_facility")
    else
      render(:action => 'new_facility')
    end
  end

  def show_facility
    @facility = Facility.find(params[:id])
  end

  def edit_facility
    @facility = Facility.find(params[:id])
  end
  
  def update_facility
    @facility = Facility.find(params[:id])
    if @facility.update_attributes(params[:facility])
      flash[:notice] = _('Facility was successfully updated.')
      redirect_to(:action => 'list_facility')
    else
      render(:action => 'edit_facility')
    end
  end

  def destroy_facility
    Facility.find(params[:id]).destroy
    redirect_to(:action => 'list_facility')
  end


  def list_facilitycat
    @facilitycats = Facilitycat.paginate(:page => params[:page], :per_page => 30)
  end

  def new_facilitycat
    @facilitycat = Facilitycat.new
  end

  def create_facilitycat
    @facilitycat = Facilitycat.new(params[:facilitycat])
    if @facilitycat.save
      flash['notice']  = _("Facilitycat was successfully created")
      redirect_to(:action => "list_facilitycat")
    else
      render(:action => 'new_facilitycat')
    end
  end

  def show_facilitycat
    @facilitycat = Facilitycat.find(params[:id])
  end

  def edit_facilitycat
    @facilitycat = Facilitycat.find(params[:id])
  end
  
  def update_facilitycat
    @facilitycat = Facilitycat.find(params[:id])
    if @facilitycat.update_attributes(params[:facilitycat])
      flash[:notice] = _('Facilitycat was successfully updated.')
      redirect_to(:action => 'list_facilitycat')
    else
      render(:action => 'edit_facilitycat')
    end
  end

  def destroy_facilitycat
    Facilitycat.find(params[:id]).destroy
    redirect_to(:action => 'list_facilitycat')
  end

  def list_particular
    #@particular_pages, @particulars = paginate(:particulars, :per_page => 100, :order => 'particulars.seq', :include => [:particularcat])
    @particulars = Particular.paginate(:page => params[:page], :per_page => 100, :order => 'particulars.seq', :include => [:particularcat])
  end

  def xml_export_particular
    @particulars = Particular.find(:all, :order => 'particulars.seq', :include => [:particularcat])
    response.headers['Content-Type'] = 'application/vnd.ms-excel'
    response.headers['Content-Disposition'] = 'attachment; filename="particulars.xml"'
  end


  def new_particular
    @particular = Particular.new
  end

  def create_particular
    @particular = Particular.new(params[:particular])
    if @particular.save
      flash['notice']  = _("Particular was successfully created")
      redirect_to(:action => "list_particular")
    else
      render(:action => 'new_particular')
    end
  end

  def show_particular
    @particular = Particular.find(params[:id])
  end

  def edit_particular
    @particular = Particular.find(params[:id])
  end
  
  def update_particular
    @particular = Particular.find(params[:id])
    if @particular.update_attributes(params[:particular])
      flash[:notice] = _('Particular was successfully updated.')
      redirect_to(:action => 'list_particular')
    else
      render(:action => 'edit_particular')
    end
  end

  def destroy_particular
    Particular.find(params[:id]).destroy
    redirect_to(:action => 'list_particular')
  end


  def list_particularcat
#    @particularcat_pages, @particularcats = paginate(:particularcats, :per_page => 30)
    @particularcats = Particularcat.paginate(:page => params[:page], :per_page => 30)
   end

  def new_particularcat
    @particularcat = Particularcat.new
  end

  def create_particularcat
    @particularcat = Particularcat.new(params[:particularcat])
    if @particularcat.save
      flash['notice']  = "Particularcat was successfully created"
      redirect_to(:action => "list_particularcat")
    else
      render(:action => 'new_particularcat')
    end
  end

  def show_particularcat
    @particularcat = Particularcat.find(params[:id])
  end

  def edit_particularcat
    @particularcat = Particularcat.find(params[:id])
  end
  
  def update_particularcat
    @particularcat = Particularcat.find(params[:id])
    if @particularcat.update_attributes(params[:particularcat])
      flash[:notice] = _('Particularcat was successfully updated.')
      redirect_to(:action => 'list_particularcat')
    else
      render(:action => 'edit_particularcat')
    end
  end

  def destroy_particularcat
    Particularcat.find(params[:id]).destroy
    redirect_to(:action => 'list_particularcat')
  end

  def show_shop
    @shop = Shop.find(params[:id])

#      conditions = "items.user_id = ? or
#                    items.publish_level = ? or
#                    ( items.publish_level = ? and users.group_id = ? ) ",
#                    session[:user].id,
#                    9,
#                    5,
#                    session[:user].group_id


    @page, @shopitems = paginate :shopitems,
#      :conditions => ['shop_id = ? and (
#                                          items.user_id = ? or
#                                          items.publish_level = ? or
#                                         (items.publish_level = ? and users.group_id = ? )
#                                         ) ',
#                          @shop.id, session[:user].id, 9, 5, session[:user].group_id],
      :conditions => [ 'shop_id = ? and (
                                          shopitems.publish_level = ? or
                                          shopitems.publish_level = ? 
                                         ) ',
                          @shop.id, 9, 5 ],

      :per_page => 5, :order => 'created_at DESC', :include => [:user]
#  p @page
#  p @shopitems
  end



  private
  
  def set_lat_lon_tokyo_datum_dec
    # 世界測地系(wgs84) -> 日本測地系(Tokyo Datum) 変換 
    params[:spot][:longitude_tokyo_datum_dec] = params[:spot][:longitude].to_f + params[:spot][:latitude].to_f * 0.000046047 + params[:spot][:longitude].to_f * 0.000083049 - 0.010041
    params[:spot][:latitude_tokyo_datum_dec]  = params[:spot][:latitude].to_f + params[:spot][:latitude].to_f * 0.00010696 - params[:spot][:longitude].to_f * 0.000017467 - 0.0046020
  end

  def set_lat_lon_tokyo_datum_ddmmsss
    @lat_lon_tokyo_datum_dec = params[:spot][:longitude_tokyo_datum_dec].to_f
    conv_lat_lon_tokyo_datum_dec_to_ddmmsss
    params[:spot][:longitude_tokyo_datum_ddmmsss] = @lat_lon_tokyo_datum_ddmmsss
    @lat_lon_tokyo_datum_dec = params[:spot][:latitude_tokyo_datum_dec].to_f
    conv_lat_lon_tokyo_datum_dec_to_ddmmsss
    params[:spot][:latitude_tokyo_datum_ddmmsss] =  @lat_lon_tokyo_datum_ddmmsss
  end

  def conv_lat_lon_tokyo_datum_dec_to_ddmmsss
    lat_lon_tokyo_datum_dd = @lat_lon_tokyo_datum_dec.to_i 
    lat_lon_tokyo_datum_mm = ((@lat_lon_tokyo_datum_dec - lat_lon_tokyo_datum_dd) * 60 ).to_i
    lat_lon_tokyo_datum_ss = ( @lat_lon_tokyo_datum_dec - lat_lon_tokyo_datum_dd - lat_lon_tokyo_datum_mm / 60.0 ) * 3600 
    lat_lon_tokyo_datum_sss = sprintf("%6.3f", lat_lon_tokyo_datum_ss).to_f
    @lat_lon_tokyo_datum_ddmmsss = lat_lon_tokyo_datum_dd.to_s + "." +
                                        lat_lon_tokyo_datum_mm.to_s + "." +
                                        lat_lon_tokyo_datum_sss.to_s
  end

  def set_torihiki_taiyou
    @torihiki_taiyou =  { 1 => _('baikai'),
                          2 => _('kasinusi'),
                          3 => _('urinusi'),
                          4 => _('dairi'),
                          9 => _('other') }
  end
  def set_grade_list
    @grade_list =  { 0 => _('grade_k'),
                     1 => _('grade_1'),
                     2 => _('grade_2'),
                     3 => _('grade_3'),
                     4 => _('grade_4'),
                     5 => _('grade_5'),
                     6 => _('grade_6'),
                     7 => _('grade_7'),
                     8 => _('grade_8'),
                     9 => _('grade_9'),
                     10 => _('grade_10'),
                     11 => _('grade_11'),
                     12 => _('grade_12'),
                     13 => _('grade_13'),
                     14 => _('grade_14'),
                     15 => _('grade_15'),
                     16 => _('grade_16'),
                     90 => _('grade_t'),
                     17 => _('grade_17') }
  end

end
