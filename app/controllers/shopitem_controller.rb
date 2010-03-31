require 'csis_geocoding'
require 'jcode'
#require 'xmlrpc/client'
class ShopitemController < ApplicationController

  def xml_export_shopitem
    @shopitems = Shopitem.find(:all, :order => 'created_at DESC',
                             :include => [:user, :shop, :reviews])
    response.headers['Content-Type'] = 'application/vnd.ms-excel'
    response.headers['Content-Disposition'] = 'attachment; filename="shopitems.xml"'
  end

  def xml_export_shop
    @shops = Shop.find(:all)
    response.headers['Content-Type'] = 'application/vnd.ms-excel'
    response.headers['Content-Disposition'] = 'attachment; filename="shops.xml"'
  end


  def list
    conditions = nil
#    if keyword = params[:keyword]

    if params[:keyword_name] != '' and params[:keyword_name] != nil
      keyword = params[:keyword_name]
      keyword = "%" + keyword + "%"
    else
      keyword = "%"
    end

        if    params[:period] == '45'
          date_from = 1.year.ago.to_date
          date_to   = Time.now.tomorrow.to_date
        elsif params[:period] == '46'
          date_from = 6.months.ago.to_date
          date_to   = Time.now.tomorrow.to_date
        elsif params[:period] == '47'
          date_from = 3.months.ago.to_date
          date_to   = Time.now.tomorrow.to_date
        elsif params[:period] == '48'
          date_from = 1.month.ago.to_date
          date_to   = Time.now.tomorrow.to_date
        elsif params[:period] == '49'
          date_from = 1.week.ago.to_date
          date_to   = Time.now.tomorrow.to_date
        elsif params[:period] == '50'
          date_from = Time.now.to_date
          date_to   = Time.now.tomorrow.to_date
        elsif params[:period] == nil or params[:period] == '51'
          params[:period] = '51'
          date_from = Time.now.to_date
          date_to   = 7.days.from_now.to_date
        elsif params[:period] == '52'
          date_from = Time.now.to_date
          date_to   = Time.now.next_month.to_date
        elsif params[:period] == '53'
          date_from = Time.now.to_date
          date_to   = 3.month.from_now.to_date
        elsif params[:period] == '54'
          date_from = Time.now.to_date
          date_to   = 6.month.from_now.to_date
        elsif params[:period] == '55'
          date_from = Time.now.to_date
          date_to   = Time.now.next_year.to_date
        elsif params[:period] == '56'
          date_from = 10.years.ago.to_date
          date_to   = 10.years.from_now.to_date
        end

    
    if params[:keyword_name] != '' and params[:keyword_name] != nil
      keyword = params[:keyword_name]
      keyword = "%" + keyword + "%"
      if params[:period] == '50'
        conditions = ["(shopitems.name like ? or shopitems.genre like ? or shops.name like ? or reviews.genre like ? or reviews.hiro like ?) and
                     (shopitems.publish_level = ?) and shopitems.date_val_2 >= ?"]
        conditions << keyword
        conditions << keyword
        conditions << keyword
        conditions << keyword
        conditions << keyword
        conditions << 9
        conditions << Time.now.to_date
      else
        conditions = ["(shopitems.name like ? or shopitems.genre like ? or shops.name like ? or reviews.genre like ? or reviews.hiro like ?) and
                     (shopitems.publish_level = ?)"]
        conditions << keyword
        conditions << keyword
        conditions << keyword
        conditions << keyword
        conditions << keyword
        conditions << 9
      end
    else
      if session[:user]
        if params[:past_flg] == '0'
          if session[:user].level == 0
            conditions = "shopitems.date_val_2 >= ?",
                      Time.now.to_date
          else
            conditions = "shopitems.publish_level = ? or
                      ( shopitems.publish_level = ? and users.group_id = ? ) and shopitems.date_val_2 >= ?",
                      9,
                      5,
                      session[:user].group_id,
                      Time.now.to_date
          end
        else
          if session[:user].level == 0
            conditions = ""
          else
            conditions = "shopitems.publish_level = ? or
                      ( shopitems.publish_level = ? and users.group_id = ? ) ",
                      9,
                      5,
                      session[:user].group_id
          end
        end
      else
      end

#      conditions = "shopitems.date_val_2 >= ?",
#                    Time.now.to_date

    end  


        conditions = "(shopitems.name like ? or shopitems.genre like ? or shops.name like ? or reviews.genre like ? or reviews.hiro like ?) and
                     (shopitems.publish_level = ?) and shopitems.date_val_2 >= ? and shopitems.date_val_2 < ?",
                      keyword,
                      keyword,
                      keyword,
                      keyword,
                      keyword,
                      9,
                      date_from,
                      date_to




#    @page, @shopitems = paginate :shopitems, :order => 'created_at DESC', :per_page => 5,
#                             :conditions => conditions, :include => [:shop, :user]

#    @shopitems = Shopitem.paginate(:page => params[:page], :order => 'shopitems.name_kana ASC', :per_page => 50,
#                             :conditions => conditions, :include => [:shop, :user, :reviews ])

    @shopitems = Shopitem.paginate(:page => params[:page], :order => 'shopitems.date_val_2 ASC', :per_page => 500,
                             :conditions => conditions, :include => [:shop, :user, :reviews, :spot ])

    p @shopitems
  end

  def list_by_author
    conditions = nil

    if params[:keyword_name] != '' and params[:keyword_name] != nil
      keyword = params[:keyword_name]
      keyword = "%" + keyword + "%"
    else
      keyword = "%"
    end

   p keyword

        if    params[:period] == '45'
          date_from = 1.year.ago.to_date
          date_to   = Time.now.tomorrow.to_date
        elsif params[:period] == '46'
          date_from = 6.months.ago.to_date
          date_to   = Time.now.tomorrow.to_date
        elsif params[:period] == '47'
          date_from = 3.months.ago.to_date
          date_to   = Time.now.tomorrow.to_date
        elsif params[:period] == '48'
          date_from = 1.month.ago.to_date
          date_to   = Time.now.tomorrow.to_date
        elsif params[:period] == '49'
          date_from = 1.week.ago.to_date
          date_to   = Time.now.tomorrow.to_date
        elsif params[:period] == '50'
          date_from = Time.now.to_date
          date_to   = Time.now.tomorrow.to_date
        elsif params[:period] == nil or params[:period] == '51'
          params[:period] = '51'
          date_from = Time.now.to_date
          date_to   = 7.days.from_now.to_date
        elsif params[:period] == '52'
          date_from = Time.now.to_date
          date_to   = Time.now.next_month.to_date
        elsif params[:period] == '53'
          date_from = Time.now.to_date
          date_to   = 3.month.from_now.to_date
        elsif params[:period] == '54'
          date_from = Time.now.to_date
          date_to   = 6.month.from_now.to_date
        elsif params[:period] == '55'
          date_from = Time.now.to_date
          date_to   = Time.now.next_year.to_date
        elsif params[:period] == '56'
          date_from = 10.years.ago.to_date
          date_to   = 10.years.from_now.to_date
        end


    if params[:keyword_name] != '' and params[:keyword_name] != nil
      keyword = "%" + keyword + "%"
#      conditions = ["(name like ?)"]
#      conditions = ["shops.name like ?"]
      conditions = ["(shopitems.name like ? or shopitems.author like ? or shopitems.genre like ? or shops.name like ? or reviews.genre like ? or reviews.hiro like ?) and
                     (shopitems.publish_level = ? )"]
      conditions << keyword
      conditions << keyword
      conditions << keyword
      conditions << keyword
      conditions << keyword
      conditions << keyword
#      conditions << session[:user].id
#      conditions << 1
      conditions << 9
#      conditions << 5
#      conditions << session[:user].group_id
#      conditions << 1
    else
      if session[:user]
        if session[:user].level == 0
        conditions = ""
                    #  session[:user].id,
        else
        conditions = "shopitems.publish_level = ? or
                      ( shopitems.publish_level = ? and users.group_id = ? ) ",
                    #  session[:user].id,
                    #  1,
                      9,
                      5,
                      session[:user].group_id
        end
      else
        conditions = "shopitems.publish_level = ?",
                    #  session[:user].id,
                    #  1,
                      9

      end
    end

#      conditions = ["(shopitems.name like ? or shopitems.author like ? or shopitems.genre like ? or shops.name like ? or reviews.genre like ? or reviews.hiro like ?) and
#                     (shopitems.publish_level = ? )"]

p keyword

       conditions = "(shopitems.name like ? or shopitems.author like ? or shopitems.genre like ? or shops.name like ? or reviews.genre like ? or reviews.hiro like ?) and
                     (shopitems.publish_level = ?) and shopitems.date_val_2 >= ? and shopitems.date_val_2 < ?",
                      keyword,
                      keyword,
                      keyword,
                      keyword,
                      keyword,
                      keyword,
                      9,
                      date_from,
                      date_to

    




#    @page, @shopitems = paginate :shopitems, :order => 'created_at DESC', :per_page => 5,
#                             :conditions => conditions, :include => [:shop, :user]

    @shopitems = Shopitem.paginate(:page => params[:page], :order => 'shops.name, date_val_2 ASC', :per_page => 500,
                             :conditions => conditions, :include => [:shop, :user, :reviews ])



  end


  def list_recommend
    conditions = nil
    if keyword = params[:keyword]
      keyword = "%" + keyword + "%"
#      conditions = ["(name like ?)"]
#      conditions = ["shops.name like ?"]
      conditions = ["((shopitems.genre like ? or shopitems.theme like ? or shopitems.tag like ? or shopitems.name like ? ) and
                     (shopitems.publish_level = ? and
                      shopitems.recommend_grade_flg_00 = ? ))"]
      conditions << keyword
      conditions << keyword
      conditions << keyword
      conditions << keyword
#      conditions << session[:user].id
#      conditions << 1
      conditions << 9
#      conditions << 5
#      conditions << session[:user].group_id
#      conditions << 1
      conditions << 1
    else
      if session[:user]
        if session[:user].level == 0
        conditions = ""
                    #  session[:user].id,
        else
        conditions = "shopitems.publish_level = ? and shopitems.recommend_grade_flg_00 = ? or
                      ( shopitems.publish_level = ? and users.group_id = ? ) ",
                    #  session[:user].id,
                    #  1,
                      9,
                      5,
                      session[:user].group_id
        end
        conditions = "shopitems.publish_level = ? and shopitems.recommend_grade_flg_00 = ?",
                    #  session[:user].id,
                    #  1,
                      9,
                      1

      end
    end
#    @page, @shopitems = paginate :shopitems, :order => 'created_at DESC', :per_page => 5,
#                             :conditions => conditions, :include => [:shop, :user]

    @shopitems = Shopitem.paginate(:page => params[:page], :order => 'shopitems.name_kana ASC', :per_page => 50,
                             :conditions => conditions, :include => [:shop, :user, :reviews ])

  end



  def new
  end

  def new_shop
    render :partial => 'shop_form'
  end

  def new_shop_ind
    @shop = Shop.new
  end

  def create
    begin 
      create_shop
      create_shopitem
    rescue
      log_error($!)
      render :action => :new
      return
    end
    flash[:message] = _('new item successfully created')
    redirect_to :action => :show, :id => @shopitem
  end

  def create_by_l2
    begin
      create_shop
      create_shopitem
    rescue
      log_error($!)
      render :action => :new_by_l2
      return
    end
    flash[:message] = _('new item successfully created')
    redirect_to :action => :show, :id => @shopitem
  end

  def zip_spot
#    @prefecture, @address1, @address2 = Shop.zip2address(params[:zip])
#    @prefecture, @address1 = Shop.zip2address(params[:zip])
#
    p params[:zip]
    @prefecture = Spot.zip2address(params[:zip])
    p @prefecture
#    p params[:zip]
#    p @prefecture
  end

  def zip_shop
#    @prefecture, @address1, @address2 = Shop.zip2address(params[:zip])
#    @prefecture, @address1 = Shop.zip2address(params[:zip])
#
    p params[:zip]
    @prefecture = Shop.zip2address(params[:zip])
    p @prefecture
#    p params[:zip]
#    p @prefecture
  end

  def geocoding
    @candidates = CSIS::Geocoding.new(params[:shop][:address], params[:series]).candidates
    p @candidates
    render :partial => 'address_option'
  end

  def geocoding_spot
    @candidates = CSIS::Geocoding.new(params[:spot][:address], params[:series]).candidates
    render :partial => 'address_option'
  end


  def by_map

#    conditions = nil
#    conditions = "shops.user_id = ? or
#                  users.group_id = ? ",
#                  session[:user].id,
#                  session[:user].group_id
#    @page, @shops = paginate :shops, :per_page => 100,
#                             :conditions => conditions, :include => :user

#if session[:user]
#    conditions = nil
#    conditions = "shops.user_id = ? or
#                ( shops.group_id = ? and shops.publish_level = ? ) or
#                  shops.publish_level = ? ",
#                  session[:user].id,
#                  session[:user].group_id,
#                  5,
#                  9
#                  
#    @page, @shops = paginate :shops, :per_page => 100,
#                             :conditions => conditions, :include => :user
#else
#    conditions = nil
#    conditions = "shops.publish_level = ? ",
#                  9
#    @page, @shops = paginate :shops, :per_page => 100,
#                             :conditions => conditions

    
    @page, @shops = paginate :shops, :per_page => 100
#end
  end

  def create_shop_ind
    if params[:shop]
      if @shop_exist = Shop.find(:first, :conditions => ["shops.name = ?", params[:shop][:name]])
        flash[:message] = _('shop_name already exist')
        redirect_to :action => :new_shop_ind
      else
        set_lat_lon_tokyo_datum_dec
        set_lat_lon_tokyo_datum_ddmmsss
        @shop = Shop.new(params[:shop])
        if session[:user]
          @shop.user_id = session[:user].id
          @shop.group_id = session[:user].group_id
        else
          @shop.user_id = 1
          @shop.group_id = 1
        end
        @shop.latitude = 0.0 if @shop.latitude == nil
        @shop.longitude = 0.0 if @shop.longitude == nil
        @shop.save!
        notice_shop_to_admin
        flash[:message] = _('shop successfully created')
        redirect_to :action => :show_shop, :id => @shop
      end
    end
  end

  def create_spot
    if params[:spot]
      if @spot_exist = Spot.find(:first, :conditions => ["spots.name = ?", params[:spot][:name]])
        params[:shopitem][:spot_id] = @spot_exist.id
      else
        set_lat_lon_tokyo_datum_dec_spot
        set_lat_lon_tokyo_datum_ddmmsss_spot
        @spot = Spot.new(params[:spot])
        @spot.user_id = session[:user].id
        @spot.group_id = session[:user].group_id
        @spot.latitude = 0.0 if @spot.latitude == nil
        @spot.longitude = 0.0 if @spot.longitude == nil
        @spot.save!
        params[:shopitem][:spot_id] = @spot.id
      end
    end
  end

  def create_shop
    if params[:shop]
      if @shop_exist = Shop.find(:first, :conditions => ["shops.name = ?", params[:shop][:name]])
        params[:shopitem][:shop_id] = @shop_exist.id
      else
        set_lat_lon_tokyo_datum_dec
        set_lat_lon_tokyo_datum_ddmmsss
        @shop = Shop.new(params[:shop])
        @shop.user_id = session[:user].id
        @shop.group_id = session[:user].group_id
        @shop.latitude = 0.0 if @shop.latitude == nil
        @shop.longitude = 0.0 if @shop.longitude == nil
        @shop.save!
        params[:shopitem][:shop_id] = @shop.id
      end
    end
  end

  def create_shop_sav_20100118
    if params[:shop]

      set_lat_lon_tokyo_datum_dec
      set_lat_lon_tokyo_datum_ddmmsss

      @shop = Shop.new(params[:shop])
      @shop.user_id = session[:user].id
      @shop.group_id = session[:user].group_id
      @shop.save!
      params[:shopitem][:shop_id] = @shop.id
      @shop = nil
    end
  end

  def update_shopitem

    params[:shopitem][:created_at] = param_time()

    if params[:shopitem][:genre_wk] != ""
      params[:shopitem][:genre] = params[:shopitem][:genre_wk]
      params[:shopitem][:genre_wk] = nil
    end

    if params[:shopitem][:theme_wk] != ""
      params[:shopitem][:theme] = params[:shopitem][:theme_wk]
      params[:shopitem][:theme_wk] = nil
    end

    if params[:shopitem][:str_val_2] != ""
      params[:shopitem][:str_val_1] = params[:shopitem][:str_val_2]
      params[:shopitem][:str_val_2] = nil
    end

    if params[:shopitem][:str_val_6] != ""
      params[:shopitem][:str_val_5] = params[:shopitem][:str_val_6]
      params[:shopitem][:str_val_6] = nil
    end
    
    if params[:shopitem][:di_flg] == 1
       author_kata = params[:shopitem][:author].tr('ａ-ｚＡ-Ｚぁ-ん０-９', 'a-zA-Zァ-ン0-9')
       params[:shopitem][:author] = author_kata
      if params[:shopitem][:illustrator]
        illustrator_kata = params[:shopitem][:illustrator].tr('ａ-ｚＡ-Ｚぁ-ん０-９', 'a-zA-Zァ-ン0-9')
        params[:shopitem][:illustrator] = illustrator_kata
      end

    end

    params[:shopitem][:tag_list] = params[:shopitem][:genre] + " " + params[:shopitem][:theme] + " " + params[:shopitem][:tag]

    Shopitem.transaction do
      unless @shopitem.update_attributes(params[:shopitem])
        raise 'failed to update'
      end
      save_pics
      notice_shopitem_to_admin_and_teacher
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

  def create_shopitem

    params[:shopitem][:created_at] = param_time()

    if params[:shopitem][:genre_wk] != ""
      params[:shopitem][:genre] = params[:shopitem][:genre_wk]
      params[:shopitem][:genre_wk] = nil
    end

    if params[:shopitem][:theme_wk] != ""
      params[:shopitem][:theme] = params[:shopitem][:theme_wk]
      params[:shopitem][:theme_wk] = nil
    end

    if params[:shopitem][:str_val_2] != ""
      params[:shopitem][:str_val_1] = params[:shopitem][:str_val_2]
      params[:shopitem][:str_val_2] = nil
    end

    if params[:shopitem][:str_val_6] != ""
      params[:shopitem][:str_val_5] = params[:shopitem][:str_val_6]
      params[:shopitem][:str_val_6] = nil
    end

    if params[:shopitem][:di_flg] == 1
       author_kata = params[:shopitem][:author].tr('ａ-ｚＡ-Ｚぁ-ん０-９', 'a-zA-Zァ-ン0-9')
       params[:shopitem][:author] = author_kata
      if params[:shopitem][:illustrator]
        illustrator_kata = params[:shopitem][:illustrator].tr('ａ-ｚＡ-Ｚぁ-ん０-９', 'a-zA-Zァ-ン0-9')
        params[:shopitem][:illustrator] = illustrator_kata
      end

    end

    params[:shopitem][:tag_list] = params[:shopitem][:genre] + " " + params[:shopitem][:theme] + " " + params[:shopitem][:tag]

#    params[:shopitem][:tag_list] = params[:shopitem][:tag]
    Shopitem.transaction do
      @shopitem = Shopitem.new(params[:shopitem])
      @shopitem.created_at = param_time()
      @shopitem.user_id = session[:user].id
      @shopitem.group_id = session[:user].group_id
      @shopitem.publish_level = 9
#      if @shopitem.genre_wk != ""
#        @shopitem.genre = @shopitem.genre_wk
#        @shopitem.genre_wk = nil
#      end
#      if @shopitem.theme_wk != ""
#        @shopitem.theme = @shopitem.theme_wk
#        @shopitem.theme = nil
#      end

#      if @shopitem.di_flg
#        author_kata = @shopitem.author.tr('ａ-ｚＡ-Ｚぁ-ん０-９', 'a-zA-Zァ-ン0-9')
#        @shopitem.author = author_kata
#        if @shopitem.illustrator
#          illustrator_kata = @shopitem.illustrator.tr('ａ-ｚＡ-Ｚぁ-ん０-９', 'a-zA-Zァ-ン0-9')
#          @shopitem.illustrator = illustrator_kata
#        end
#      end

      @shopitem.save!
      save_pics
      notice_shopitem_to_admin_and_teacher
    end
  end

  def replicate_shopitem
    @shopitem_org = Shopitem.find(params[:id])
#    p @shopitem_org
    Shopitem.transaction do
      @shopitem = Shopitem.new
#      @shopitem_id_save = @shopitem.id
#      p @shopitem_id_save
#      p @shopitem
#      @shopitem = @shopitem_org
#      @shopitem.id = @shopitem_id_save
      @shopitem.name = @shopitem_org.name
      @shopitem.name_kana = @shopitem_org.name_kana
      @shopitem.shop_id = @shopitem_org.shop_id
      @shopitem.spot_id = @shopitem_org.spot_id
      @shopitem.publish_level = @shopitem_org.publish_level
      @shopitem.publish_date = @shopitem_org.publish_date
      @shopitem.group_id = @shopitem_org.group_id
      @shopitem.user_id = @shopitem_org.user_id
      @shopitem.item_id = @shopitem_org.item_id
      @shopitem.genre = @shopitem_org.genre
      @shopitem.theme = @shopitem_org.theme
      @shopitem.date_val_1 = @shopitem_org.date_val_1
      @shopitem.date_val_2 = @shopitem_org.date_val_2
      @shopitem.date_val_3 = @shopitem_org.date_val_3
      @shopitem.str_val_1 = @shopitem_org.str_val_1
      @shopitem.str_val_3 = @shopitem_org.str_val_3
      @shopitem.str_val_4 = @shopitem_org.str_val_4
      @shopitem.str_val_5 = @shopitem_org.str_val_5
      @shopitem.num_val_1 = @shopitem_org.num_val_1
      @shopitem.num_val_2 = @shopitem_org.num_val_2
      @shopitem.memo = @shopitem_org.memo
      @shopitem.tag = @shopitem_org.tag
      @shopitem.hero = @shopitem_org.hero
      @shopitem.recommend_grade_flg_00 = @shopitem_org.recommend_grade_flg_00
      @shopitem.recommend_grade_flg_01 = @shopitem_org.recommend_grade_flg_01
      @shopitem.recommend_grade_flg_02 = @shopitem_org.recommend_grade_flg_02
      @shopitem.recommend_grade_flg_03 = @shopitem_org.recommend_grade_flg_03
      @shopitem.recommend_grade_flg_04 = @shopitem_org.recommend_grade_flg_04
      @shopitem.recommend_grade_flg_05 = @shopitem_org.recommend_grade_flg_05
      @shopitem.recommend_grade_flg_06 = @shopitem_org.recommend_grade_flg_06
      @shopitem.recommend_grade_flg_07 = @shopitem_org.recommend_grade_flg_07
      @shopitem.recommend_grade_flg_08 = @shopitem_org.recommend_grade_flg_08
      @shopitem.recommend_grade_flg_09 = @shopitem_org.recommend_grade_flg_09
#       @shopitem = @shopitem_org
#       @shopitem.id = nil
#      p @shopitem
      @shopitem.save!
    end
#    p @shopitem
    redirect_to :action => :edit_by_l2, :id => @shopitem.id
  end

  def create_shopitem_from_item
#    :name, :name_kana, :shop_id
    @item = Item.find(params[:id])
#    p @shopitem_org
    Shopitem.transaction do
      @shopitem = Shopitem.new
#      @shopitem_id_save = @shopitem.id
#      p @shopitem_id_save
#      p @shopitem
#      @shopitem = @shopitem_org
#      @shopitem.id = @shopitem_id_save
      @shopitem.name = @item.name
      @shopitem.name_kana = @item.str_val_7
      @shopitem.shop_id = @item.shop_id
      @shopitem.publish_level = @item.publish_level
      @shopitem.publish_date = @item.created_at
      @shopitem.group_id = @item.group_id
      @shopitem.user_id = @item.user_id
      @shopitem.item_id = @item.id
      @shopitem.date_val_1 = @item.date_val_1
      @shopitem.date_val_2 = @item.date_val_2
      @shopitem.date_val_3 = @item.date_val_3
      @shopitem.num_val_1 = @item.num_val_p
      @shopitem.str_val_3 = @item.str_val_2
      @shopitem.str_val_5 = @item.str_val_3
      @shopitem.memo = @item.memo
      @shopitem.hero = @item.str_val_1
      @shopitem.spot_id = @item.spot_id
#      @shopitem.recommend_grade_flg_00 = @shopitem_org.recommend_grade_flg_00
#       @shopitem = @shopitem_org
#       @shopitem.id = nil
#      p @shopitem
      @shopitem.save!
    end
#    p @shopitem
    redirect_to :action => :edit_by_l2, :id => @shopitem.id

  end


  def save_pics
    [:picture0, :picture1, :picture2, :picture3, :picture4].each do |pic|  
      next if params[pic].nil?
      next if params[pic][:file].nil?
      next if params[pic][:file].length == 0
      @picture = @shopitem.pictures.build
      @picture.file = params[pic][:file]
      @picture.title = params[pic][:title]
      @picture.save!
    end
  end
  
  def param_time()
    Time.local(params[:date][:year],
               params[:date][:month],
               params[:date][:day],
               params[:date][:hour],
               params[:date][:minute])
  end
    
  def show
    @shopitem = Shopitem.find(params[:id], :include => :reviews )
  end

  def edit
    @shopitem = Shopitem.find(params[:id])

#    p @shopitem.user_id
#    p session[:user].id

    unless @shopitem.user_id == session[:user].id or session[:user][:level] == 0 or ( session[:user][:level] == 3 and @shopitem.group_id == session[:user][:group_id] )
      flash[:message] = _('error user unmuch')
      redirect_to :action => :show, :id => @shopitem
    end
  end

  def edit_by_l2
    @shopitem = Shopitem.find(params[:id])

#    p @shopitem.user_id
#    p session[:user].id

    if session[:user]
      unless @shopitem.user_id == session[:user].id or session[:user][:level] <= 2 or ( session[:user][:level] == 3 and @shopitem.group_id == session[:user][:group_id] )
      flash[:message] = _('error user unmuch')
      redirect_to :action => :show, :id => @shopitem
      end
    end
  end


  def update
    @shopitem = Shopitem.find(params[:id])

    begin
      create_spot
      create_shop
      update_shopitem
      delete_pics
    rescue
      log_error($!)
      render :action => :edit
      return
    end
    flash[:message] = _('shopitem successfully updated')
    redirect_to :action => :show, :id => @shopitem
  end

  def delete
    @shopitem = Shopitem.find(params[:id])
  end

  def remove
    @shopitem = Shopitem.find(params[:id])
    @shopitem.destroy
    flash[:message] = _('shopitem successfully deleted')
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

  def list_shop
    conditions = nil
    if keyword = params[:keyword]
      keyword = "%" + keyword + "%"
#      conditions = ["(name like ?)"]
#      conditions = ["shops.name like ?"]
      conditions = ["(shops.name like ? and
                     shops.publish_level = ?)"]
      conditions << keyword
      conditions << 9

    else
      if session[:user]
        if session[:user].level == 0
        conditions = ""
                    #  session[:user].id,
        else
        conditions = "shops.publish_level = ? or
                      ( shops.publish_level = ? and users.group_id = ? ) ",
                    #  session[:user].id,
                    #  1,
                      9,
                      5,
                      session[:user].group_id
        end
      else
        conditions = "shops.publish_level = ?",
                    #  session[:user].id,
                    #  1,
                      9
      end

    end

#    @page, @shopitems = paginate :shopitems, :order => 'created_at DESC', :per_page => 5,
#                             :conditions => conditions, :include => [:shop, :user]

#    @shopitems = Shopitem.paginate(:page => params[:page], :order => 'shopitems.name_kana ASC', :per_page => 50,
#                             :conditions => conditions, :include => [:shop, :user, :reviews ])

#    @shops = Shop.paginate(:page => params[:page], :order => 'shops.mame ASC', :per_page => 50,
#                             :conditions => conditions, :include => [:shop, :user, :reviews ])
    @shops = Shop.paginate(:page => params[:page], :order => 'shops.name ASC', :per_page => 1000,
                             :conditions => conditions)

#    @shops = Shop.paginate(:page => params[:page], :per_page => 10)

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


    @shopitems = Shopitem.paginate(:page => params[:page],
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

      :per_page => 50, :order => 'date_val_2 ASC', :include => [:user])
#  p @page
#  p @shopitems
  end

  def show_shop_map
    @shop = Shop.find(params[:id])
  end

  def send_shop_map_by_mail
    $user_email_cell = session[:user].email_cell
    @shop = Shop.find(params[:id])
    Mailer.deliver_send_shop_map_by_mail(@shop)
    flash[:message] =  _('mail was sent')
    redirect_to :action => :show_shop, :id => @shop
  end


  def edit_shop
    @shop = Shop.find(params[:id])
    unless @shop.user_id == session[:user].id or session[:user][:level] == 0
      flash[:message] = _('error user unmuch')
      redirect_to :action => :show_shop, :id => @shop
    end
  end

  
  def update_shop
    @shop = Shop.find(params[:id])
 
    set_lat_lon_tokyo_datum_dec
    set_lat_lon_tokyo_datum_ddmmsss

#    @shop.user_id = session[:user].id

    unless @shop.update_attributes(params[:shop])
      render :action => :edit_shop
    else
      flash[:message] = _('shop successfully updated')
      redirect_to url_for(:action => :show_shop, :id => @shop)
    end
  end

  def delete_shop

    @shop = Shop.find(params[:id])

#      conditions = "items.user_id = ? or
#                    items.publish_level = ? or
#                    ( items.publish_level = ? and users.group_id = ? ) ",
#                    session[:user].id,
#                    9,
#                    5,
#                    session[:user].group_id


#    @page, @shopitems = paginate :shopitems,
#      :conditions => ['spot_id = ? and (
#                                          items.user_id = ? or
#                                          items.publish_level = ? or
#                                         (items.publish_level = ? and users.group_id = ? )
#                                         ) ',
#                          @spot.id, session[:user].id, 9, 5, session[:user].group_id],
#      :conditions => [ 'shop_id = ? and (
#                                          shopitems.publish_level = ? or
#                                          shopitems.publish_level = ?
#                                         ) ',
#                          @shop.id, 9, 5 ],

#      :per_page => 5, :order => 'created_at DESC', :include => [:user]


    @shopitems = Shopitem.paginate(:page => params[:page],
      #      :conditions => ['spot_id = ? and (
#                                          items.user_id = ? or
#                                          items.publish_level = ? or
#                                         (items.publish_level = ? and users.group_id = ? )
#                                         ) ',
#                          @spot.id, session[:user].id, 9, 5, session[:user].group_id],
      :conditions => [ 'shop_id = ? and (
                                          shopitems.publish_level = ? or
                                          shopitems.publish_level = ?
                                         ) ',
                          @shop.id, 9, 5 ],

      :per_page => 5, :order => 'created_at DESC', :include => [:user])





  end

  def remove_shop
    @shop = Shop.find(params[:id])
    @shop.destroy
    flash[:message] = _('shop successfully deleted')
    redirect_to :action => 'list_shop'
  end



  def list_category
    @category_pages, @categories = paginate(:categories, :per_page => 10)
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

  def new_spot
    render :partial => 'spot_form'
  end

  private

  def notice_shopitem_to_admin_and_teacher

  #  @teachar1 = User.find(:first, :conditions => ["group_id = ? and level = 3", session[:user].group_id]).email_pc
  #  @teachar2 = User.find(:second, :conditions => ["group_id = ? and level = 3", session[:user].group_id]).email_pc
    @admin = User.find_by_sql("SELECT email_pc from users WHERE level = 0")
    #p @admin[:email_pc]
  $admin_email_pc = "info@spa.fsr.jp"
  $admin_email_pc = @admin[0].email_pc if @admin[0]
  $admin_email_pc = @admin[0].email_pc + "," + @admin[1].email_pc if @admin[1]
  $admin_email_pc = @admin[0].email_pc + "," + @admin[1].email_pc + "," + @admin[2].email_pc if @admin[2]

  if session[:user]
    @teachar3 = User.find_by_sql("SELECT email_pc from users WHERE group_id  = '" + session[:user].group_id.to_s + "' and level = 3")
  else
    @teachar3 = []
  end
    #p @teachar[:email_pc]
  $teachar_email_pc = "info@spa.fsr.jp"
  $teachar_email_pc = @teachar3[0].email_pc if @teachar3[0]
  $teachar_email_pc = @teachar3[0].email_pc + "," + @teachar3[1].email_pc if @teachar3[1]
  $teachar_email_pc = @teachar3[0].email_pc + "," + @teachar3[1].email_pc + "," + @teachar3[2].email_pc if @teachar3[2]

    @shopitem = Shopitem.find(params[:id]) if @shopitem == nil

    Mailer.deliver_notice_shopitem_to_admin_and_teachar(@shopitem)
#    flash[:message] = _('mail was sent')
#    redirect_to :action => :show_spot, :id => @spot
  end

  def notice_shop_to_admin

  #  @teachar1 = User.find(:first, :conditions => ["group_id = ? and level = 3", session[:user].group_id]).email_pc
  #  @teachar2 = User.find(:second, :conditions => ["group_id = ? and level = 3", session[:user].group_id]).email_pc
    @admin = User.find_by_sql("SELECT email_pc from users WHERE level = 0")
    #p @admin[:email_pc]
  $admin_email_pc = "info@spa.fsr.jp"
  $admin_email_pc = @admin[0].email_pc if @admin[0]
  $admin_email_pc = @admin[0].email_pc + "," + @admin[1].email_pc if @admin[1]
  $admin_email_pc = @admin[0].email_pc + "," + @admin[1].email_pc + "," + @admin[2].email_pc if @admin[2]

  if session[:user]
    @teachar3 = User.find_by_sql("SELECT email_pc from users WHERE group_id  = '" + session[:user].group_id.to_s + "' and level = 3")
  else
    @teachar3 = []
  end
    #p @teachar[:email_pc]
  $teachar_email_pc = "info@spa.fsr.jp"
  $teachar_email_pc = @teachar3[0].email_pc if @teachar3[0]
  $teachar_email_pc = @teachar3[0].email_pc + "," + @teachar3[1].email_pc if @teachar3[1]
  $teachar_email_pc = @teachar3[0].email_pc + "," + @teachar3[1].email_pc + "," + @teachar3[2].email_pc if @teachar3[2]

    @shop = Shopitem.find(params[:id]) if @shop == nil

    Mailer.deliver_notice_shop_to_admin(@shop)
#    flash[:message] = _('mail was sent')
#    redirect_to :action => :show_spot, :id => @spot
  end


  def set_lat_lon_tokyo_datum_dec
    # 世界測地系(wgs84) -> 日本測地系(Tokyo Datum) 変換 
    params[:shop][:longitude_tokyo_datum_dec] = params[:shop][:longitude].to_f + params[:shop][:latitude].to_f * 0.000046047 + params[:shop][:longitude].to_f * 0.000083049 - 0.010041
    params[:shop][:latitude_tokyo_datum_dec]  = params[:shop][:latitude].to_f + params[:shop][:latitude].to_f * 0.00010696 - params[:shop][:longitude].to_f * 0.000017467 - 0.0046020
  end

  def set_lat_lon_tokyo_datum_dec_spot
    # 世界測地系(wgs84) -> 日本測地系(Tokyo Datum) 変換
    params[:spot][:longitude_tokyo_datum_dec] = params[:spot][:longitude].to_f + params[:spot][:latitude].to_f * 0.000046047 + params[:spot][:longitude].to_f * 0.000083049 - 0.010041
    params[:spot][:latitude_tokyo_datum_dec]  = params[:spot][:latitude].to_f + params[:spot][:latitude].to_f * 0.00010696 - params[:spot][:longitude].to_f * 0.000017467 - 0.0046020
  end

  def set_lat_lon_tokyo_datum_ddmmsss
    @lat_lon_tokyo_datum_dec = params[:shop][:longitude_tokyo_datum_dec].to_f
    conv_lat_lon_tokyo_datum_dec_to_ddmmsss
    params[:shop][:longitude_tokyo_datum_ddmmsss] = @lat_lon_tokyo_datum_ddmmsss
    @lat_lon_tokyo_datum_dec = params[:shop][:latitude_tokyo_datum_dec].to_f
    conv_lat_lon_tokyo_datum_dec_to_ddmmsss
    params[:shop][:latitude_tokyo_datum_ddmmsss] =  @lat_lon_tokyo_datum_ddmmsss
  end

  def set_lat_lon_tokyo_datum_ddmmsss_spot
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

end
