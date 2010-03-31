class StudentController < ApplicationController
  # GET /students
  # GET /students.xml
  def index
    set_grade_list
    set_sex_list
#    @students = Student.all



    @categories = Category.find(:all, :order => 'name')

    @ensens = Item.find_by_sql("SELECT str_val_4 FROM `items` GROUP BY str_val_4")
#    p options_from_collection_for_select(@categories, "id", "name")

#    @torihiki_taiyou =  {Item::TORIHIKI_TAIYOU[0][1] => Item::TORIHIKI_TAIYOU[0][0],
#                         Item::TORIHIKI_TAIYOU[1][1] => Item::TORIHIKI_TAIYOU[1][0],
#                         Item::TORIHIKI_TAIYOU[2][1] => Item::TORIHIKI_TAIYOU[2][0]}

#    set_torihiki_taiyou

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

    end

      conditions = []

      if keyword_l_name = params[:keyword_l_name] and keyword_l_name != ""
         keyword_l_name = "%" + keyword_l_name + "%"
         conditions << "students.l_name like #{Student.quote_value(keyword_l_name)}"
      end
      if keyword_f_name = params[:keyword_f_name] and keyword_f_name != ""
         keyword_f_name = "%" + keyword_f_name + "%"
         conditions << "students.f_name like #{Student.quote_value(keyword_f_name)}"
      end
      if keyword_address = params[:keyword_address] and keyword_address != ""
         keyword_address = "%" + keyword_address + "%"
         conditions << "spots.address like #{Item.quote_value(keyword_address)}"
      end
      if keyword_class = params[:keyword_class] and keyword_class != ""
         keyword_class = "%" + keyword_class + "%"
         conditions << "items.name like #{Student.quote_value(keyword_class)}"
      end
      if category = params[:category] and category != "0"
         conditions << "items.category_id = #{Student.quote_value(category)}"
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
      sql = "SELECT * FROM items "
      sql << "LEFT OUTER JOIN students ON students.item_id = items.id "
      unless conditions.empty?
        sql << %Q|WHERE (#{conditions.join(") AND (")})|
      end

        sql << " ORDER BY students.alias_kana, items.name"

      @students = Student.find_by_sql(sql)
#      @students = Student.all()
#    p @students



    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @students }
    end
  end

  def list_grade_k_1
    set_grade_list
    set_sex_list
    @categories = Category.find(:all, :order => 'name')
    @ensens = Item.find_by_sql("SELECT str_val_4 FROM `items` GROUP BY str_val_4")
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

      conditions = []
      conditions << "(students.grade = 'k' OR students.grade = '1')"
      if keyword_l_name = params[:keyword_l_name] and keyword_l_name != ""
         keyword_l_name = "%" + keyword_l_name + "%"
         conditions << "students.l_name like #{Student.quote_value(keyword_l_name)}"
      end
      if keyword_f_name = params[:keyword_f_name] and keyword_f_name != ""
         keyword_f_name = "%" + keyword_f_name + "%"
         conditions << "students.f_name like #{Student.quote_value(keyword_f_name)}"
      end
      if keyword_address = params[:keyword_address] and keyword_address != ""
         keyword_address = "%" + keyword_address + "%"
         conditions << "spots.address like #{Item.quote_value(keyword_address)}"
      end
      if keyword_class = params[:keyword_class] and keyword_class != ""
         keyword_class = "%" + keyword_class + "%"
         conditions << "items.name like #{Student.quote_value(keyword_class)}"
      end
      if category = params[:category] and category != "0"
         conditions << "items.category_id = #{Student.quote_value(category)}"
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
      sql = "SELECT * FROM items "
      sql << "LEFT OUTER JOIN students ON students.item_id = items.id "
      unless conditions.empty?
        sql << %Q|WHERE (#{conditions.join(") AND (")})|
      end

        sql << " ORDER BY students.alias_kana, items.name"

      @students = Student.find_by_sql(sql)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @students }
    end
  end

  def list_grade_2_3
    set_grade_list
    set_sex_list
    @categories = Category.find(:all, :order => 'name')
    @ensens = Item.find_by_sql("SELECT str_val_4 FROM `items` GROUP BY str_val_4")
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

      conditions = []
      conditions << "(students.grade = '2' OR students.grade = '3')"
      if keyword_l_name = params[:keyword_l_name] and keyword_l_name != ""
         keyword_l_name = "%" + keyword_l_name + "%"
         conditions << "students.l_name like #{Student.quote_value(keyword_l_name)}"
      end
      if keyword_f_name = params[:keyword_f_name] and keyword_f_name != ""
         keyword_f_name = "%" + keyword_f_name + "%"
         conditions << "students.f_name like #{Student.quote_value(keyword_f_name)}"
      end
      if keyword_address = params[:keyword_address] and keyword_address != ""
         keyword_address = "%" + keyword_address + "%"
         conditions << "spots.address like #{Item.quote_value(keyword_address)}"
      end
      if keyword_class = params[:keyword_class] and keyword_class != ""
         keyword_class = "%" + keyword_class + "%"
         conditions << "items.name like #{Student.quote_value(keyword_class)}"
      end
      if category = params[:category] and category != "0"
         conditions << "items.category_id = #{Student.quote_value(category)}"
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
      sql = "SELECT * FROM items "
      sql << "LEFT OUTER JOIN students ON students.item_id = items.id "
      unless conditions.empty?
        sql << %Q|WHERE (#{conditions.join(") AND (")})|
      end

        sql << " ORDER BY students.alias_kana, items.name"

      @students = Student.find_by_sql(sql)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @students }
    end
  end
  def list_grade_4_6
    set_grade_list
    set_sex_list
    @categories = Category.find(:all, :order => 'name')
    @ensens = Item.find_by_sql("SELECT str_val_4 FROM `items` GROUP BY str_val_4")
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

      conditions = []
      conditions << "(students.grade = '4' OR students.grade = '5' OR students.grade = '6')"
      if keyword_l_name = params[:keyword_l_name] and keyword_l_name != ""
         keyword_l_name = "%" + keyword_l_name + "%"
         conditions << "students.l_name like #{Student.quote_value(keyword_l_name)}"
      end
      if keyword_f_name = params[:keyword_f_name] and keyword_f_name != ""
         keyword_f_name = "%" + keyword_f_name + "%"
         conditions << "students.f_name like #{Student.quote_value(keyword_f_name)}"
      end
      if keyword_address = params[:keyword_address] and keyword_address != ""
         keyword_address = "%" + keyword_address + "%"
         conditions << "spots.address like #{Item.quote_value(keyword_address)}"
      end
      if keyword_class = params[:keyword_class] and keyword_class != ""
         keyword_class = "%" + keyword_class + "%"
         conditions << "items.name like #{Student.quote_value(keyword_class)}"
      end
      if category = params[:category] and category != "0"
         conditions << "items.category_id = #{Student.quote_value(category)}"
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
      sql = "SELECT * FROM items "
      sql << "LEFT OUTER JOIN students ON students.item_id = items.id "
      unless conditions.empty?
        sql << %Q|WHERE (#{conditions.join(") AND (")})|
      end

        sql << " ORDER BY students.alias_kana, items.name"

      @students = Student.find_by_sql(sql)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @students }
    end
  end

  def list_grade_7_9
    set_grade_list
    set_sex_list
    @categories = Category.find(:all, :order => 'name')
    @ensens = Item.find_by_sql("SELECT str_val_4 FROM `items` GROUP BY str_val_4")
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

      conditions = []
      conditions << "(students.grade = '7' OR students.grade = '8' OR students.grade = '9')"
      if keyword_l_name = params[:keyword_l_name] and keyword_l_name != ""
         keyword_l_name = "%" + keyword_l_name + "%"
         conditions << "students.l_name like #{Student.quote_value(keyword_l_name)}"
      end
      if keyword_f_name = params[:keyword_f_name] and keyword_f_name != ""
         keyword_f_name = "%" + keyword_f_name + "%"
         conditions << "students.f_name like #{Student.quote_value(keyword_f_name)}"
      end
      if keyword_address = params[:keyword_address] and keyword_address != ""
         keyword_address = "%" + keyword_address + "%"
         conditions << "spots.address like #{Item.quote_value(keyword_address)}"
      end
      if keyword_class = params[:keyword_class] and keyword_class != ""
         keyword_class = "%" + keyword_class + "%"
         conditions << "items.name like #{Student.quote_value(keyword_class)}"
      end
      if category = params[:category] and category != "0"
         conditions << "items.category_id = #{Student.quote_value(category)}"
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
      sql = "SELECT * FROM items "
      sql << "LEFT OUTER JOIN students ON students.item_id = items.id "
      unless conditions.empty?
        sql << %Q|WHERE (#{conditions.join(") AND (")})|
      end

        sql << " ORDER BY students.alias_kana, items.name"

      @students = Student.find_by_sql(sql)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @students }
    end
  end
  def list_grade_10_12
    set_grade_list
    set_sex_list
    @categories = Category.find(:all, :order => 'name')
    @ensens = Item.find_by_sql("SELECT str_val_4 FROM `items` GROUP BY str_val_4")
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

      conditions = []
      conditions << "(students.grade = '10' OR students.grade = '11' OR students.grade = '12')"
      if keyword_l_name = params[:keyword_l_name] and keyword_l_name != ""
         keyword_l_name = "%" + keyword_l_name + "%"
         conditions << "students.l_name like #{Student.quote_value(keyword_l_name)}"
      end
      if keyword_f_name = params[:keyword_f_name] and keyword_f_name != ""
         keyword_f_name = "%" + keyword_f_name + "%"
         conditions << "students.f_name like #{Student.quote_value(keyword_f_name)}"
      end
      if keyword_address = params[:keyword_address] and keyword_address != ""
         keyword_address = "%" + keyword_address + "%"
         conditions << "spots.address like #{Item.quote_value(keyword_address)}"
      end
      if keyword_class = params[:keyword_class] and keyword_class != ""
         keyword_class = "%" + keyword_class + "%"
         conditions << "items.name like #{Student.quote_value(keyword_class)}"
      end
      if category = params[:category] and category != "0"
         conditions << "items.category_id = #{Student.quote_value(category)}"
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
      sql = "SELECT * FROM items "
      sql << "LEFT OUTER JOIN students ON students.item_id = items.id "
      unless conditions.empty?
        sql << %Q|WHERE (#{conditions.join(") AND (")})|
      end

        sql << " ORDER BY students.alias_kana, items.name"

      @students = Student.find_by_sql(sql)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @students }
    end
  end
  def list_grade_13_16
    set_grade_list
    set_sex_list
    @categories = Category.find(:all, :order => 'name')
    @ensens = Item.find_by_sql("SELECT str_val_4 FROM `items` GROUP BY str_val_4")
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

      conditions = []
      conditions << "(students.grade = '13' OR students.grade = '14' OR students.grade = '15' OR students.grade = '16')"
      if keyword_l_name = params[:keyword_l_name] and keyword_l_name != ""
         keyword_l_name = "%" + keyword_l_name + "%"
         conditions << "students.l_name like #{Student.quote_value(keyword_l_name)}"
      end
      if keyword_f_name = params[:keyword_f_name] and keyword_f_name != ""
         keyword_f_name = "%" + keyword_f_name + "%"
         conditions << "students.f_name like #{Student.quote_value(keyword_f_name)}"
      end
      if keyword_address = params[:keyword_address] and keyword_address != ""
         keyword_address = "%" + keyword_address + "%"
         conditions << "spots.address like #{Item.quote_value(keyword_address)}"
      end
      if keyword_class = params[:keyword_class] and keyword_class != ""
         keyword_class = "%" + keyword_class + "%"
         conditions << "items.name like #{Student.quote_value(keyword_class)}"
      end
      if category = params[:category] and category != "0"
         conditions << "items.category_id = #{Student.quote_value(category)}"
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
      sql = "SELECT * FROM items "
      sql << "LEFT OUTER JOIN students ON students.item_id = items.id "
      unless conditions.empty?
        sql << %Q|WHERE (#{conditions.join(") AND (")})|
      end

        sql << " ORDER BY students.alias_kana, items.name"

      @students = Student.find_by_sql(sql)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @students }
    end
  end
  def list_grade_t
    set_grade_list
    set_sex_list
    @categories = Category.find(:all, :order => 'name')
    @ensens = Item.find_by_sql("SELECT str_val_4 FROM `items` GROUP BY str_val_4")
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

      conditions = []
      conditions << "(students.grade = '90')"
      if keyword_l_name = params[:keyword_l_name] and keyword_l_name != ""
         keyword_l_name = "%" + keyword_l_name + "%"
         conditions << "students.l_name like #{Student.quote_value(keyword_l_name)}"
      end
      if keyword_f_name = params[:keyword_f_name] and keyword_f_name != ""
         keyword_f_name = "%" + keyword_f_name + "%"
         conditions << "students.f_name like #{Student.quote_value(keyword_f_name)}"
      end
      if keyword_address = params[:keyword_address] and keyword_address != ""
         keyword_address = "%" + keyword_address + "%"
         conditions << "spots.address like #{Item.quote_value(keyword_address)}"
      end
      if keyword_class = params[:keyword_class] and keyword_class != ""
         keyword_class = "%" + keyword_class + "%"
         conditions << "items.name like #{Student.quote_value(keyword_class)}"
      end
      if category = params[:category] and category != "0"
         conditions << "items.category_id = #{Student.quote_value(category)}"
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
      sql = "SELECT * FROM items "
      sql << "LEFT OUTER JOIN students ON students.item_id = items.id "
      unless conditions.empty?
        sql << %Q|WHERE (#{conditions.join(") AND (")})|
      end

        sql << " ORDER BY students.alias_kana, items.name"

      @students = Student.find_by_sql(sql)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @students }
    end
  end
  def list_grade_17
    set_grade_list
    set_sex_list
    @categories = Category.find(:all, :order => 'name')
    @ensens = Item.find_by_sql("SELECT str_val_4 FROM `items` GROUP BY str_val_4")
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

      conditions = []
      conditions << "(students.grade = '17')"
      if keyword_l_name = params[:keyword_l_name] and keyword_l_name != ""
         keyword_l_name = "%" + keyword_l_name + "%"
         conditions << "students.l_name like #{Student.quote_value(keyword_l_name)}"
      end
      if keyword_f_name = params[:keyword_f_name] and keyword_f_name != ""
         keyword_f_name = "%" + keyword_f_name + "%"
         conditions << "students.f_name like #{Student.quote_value(keyword_f_name)}"
      end
      if keyword_address = params[:keyword_address] and keyword_address != ""
         keyword_address = "%" + keyword_address + "%"
         conditions << "spots.address like #{Item.quote_value(keyword_address)}"
      end
      if keyword_class = params[:keyword_class] and keyword_class != ""
         keyword_class = "%" + keyword_class + "%"
         conditions << "items.name like #{Student.quote_value(keyword_class)}"
      end
      if category = params[:category] and category != "0"
         conditions << "items.category_id = #{Student.quote_value(category)}"
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
      sql = "SELECT * FROM items "
      sql << "LEFT OUTER JOIN students ON students.item_id = items.id "
      unless conditions.empty?
        sql << %Q|WHERE (#{conditions.join(") AND (")})|
      end

        sql << " ORDER BY students.alias_kana, items.name"

      @students = Student.find_by_sql(sql)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @students }
    end
  end


  # GET /students/1
  # GET /students/1.xml
  def show
    set_grade_list
    set_sex_list
    @student = Student.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @student }
    end
  end

  def show_by_student
    set_grade_list
    set_sex_list
    @student = Student.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @student }
    end
  end

  # GET /students/new
  # GET /students/new.xml
  def new
    @student = Student.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @student }
    end
  end

  # GET /students/1/edit
  def edit
    @student = Student.find(params[:id])
  end

#  def edit_by_student
#    @student = Student.find(params[:id => sessino[:user_id]])
#  end

  def edit_by_student
    if @student = Student.find(:first, :conditions => ["user_id = ?", session[:user].id])
       @student = Student.find(:first, :conditions => ["user_id = ?", session[:user].id])
    else
      @student = Student.new
      @student.user_id = session[:user].id
    end

    @item = Item.find(:first, :conditions => ["id = ?", @student.item_id ])

#   if @student.update_attributes(params[:student])
#      flash[:message] = 'Student was successfully updated.'
#      redirect_to(:action => 'show', :controller => 'student' )
#    else
#      render(:action => 'edit_by_student')
##      redirect_to(:action => 'list', :controller => 'item' )
#    end
  end




  # POST /students
  # POST /students.xml
  def create
    Student.transaction do
      @student = Student.new(params[:student])
#      @student.created_at = param_time()
#      @student.user_id = session[:user].id
#      @student.group_id = session[:user].group_id
      @student.save!
      save_pics
    end

    respond_to do |format|
      if @student.save
        flash[:notice] = _('Student was successfully created.')
        format.html { redirect_to(:action => 'show', :id => @student) }
        format.xml  { render :xml => @student, :status => :created, :location => @student }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @student.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /students/1
  # PUT /students/1.xml
  def update
    if params[:id]
      @student = Student.find(params[:id])
      save_pics
      delete_pics
    else
      Student.transaction do
      @student = Student.new(params[:student])
      @student.user_id = session[:user].id
#      @student.created_at = param_time()
#      @student.user_id = session[:user].id
#      @student.group_id = session[:user].group_id
      @student.save!
      save_pics
      end
    end
    respond_to do |format|
      if @student.update_attributes(params[:student])
        flash[:notice] = _('Student was successfully updated.')
        format.html { redirect_to(:action => 'show', :id => @student) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @student.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def update_by_student
    if params[:id]
      @student = Student.find(params[:id])
#      save_pics
#      delete_pics
      respond_to do |format|
        if @student.update_attributes(params[:student])
          save_pics
          delete_pics
          flash[:notice] = _('Student was successfully updated.')
          format.html { redirect_to(:action => 'show_by_student', :id => @student) }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit_by_student" }
          format.xml  { render :xml => @student.errors, :status => :unprocessable_entity }
        end
      end

    else
      Student.transaction do
      @student = Student.new(params[:student])
      @student.user_id = session[:user].id
      @student.item_id = session[:user].group.item_id
#      @student.created_at = param_time()
#      @student.user_id = session[:user].id
#      @student.group_id = session[:user].group_id
##      @student.save!
##      save_pics
        respond_to do |format|
          if @student.save
            save_pics
            flash[:notice] = _('Student was successfully updated.')
            format.html { redirect_to(:action => 'show_by_student', :id => @student) }
            format.xml  { head :ok }
          else
            format.html { render :action => "edit_by_student" }
            format.xml  { render :xml => @student.errors, :status => :unprocessable_entity }
          end
        end
      end
    end

    #    redirect_to(:action => 'index')

    
  end

  def update_by_student_new
      @student = Student.find(params[:id])
    respond_to do |format|
      if @student.update_attributes(params[:student])
        flash[:notice] = _('Student was successfully updated.')
        format.html { redirect_to(:action => 'show_by_student', :id => @student) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit_by_student" }
        format.xml  { render :xml => @student.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.xml
  def destroy
    @student = Student.find(params[:id])
    @student.destroy

    respond_to do |format|
      flash[:notice] = _('Student was successfully deleted.')
      format.html { redirect_to(:action => 'index') }
      format.xml  { head :ok }
    end
  end


  def delete_pics
    return unless params[:pic]
    params[:pic].each do |k,v|
      Picture.delete(k) if v == '1'
    end
  end

  def save_pics
    [:picture0, :picture1, :picture2, :picture3, :picture4].each do |pic|
      next if params[pic].nil?
      next if params[pic][:file].nil?
      next if params[pic][:file].length == 0
      @picture = @student.pictures.build
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

  private

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
                     17 => _('grade_17'),
                     90 => _('grade_t') }
  end

  def set_sex_list
    @sex_list =  { 0 => _('female'),
                     1 => _('male'),
                     2 => _('NA') }
  end


end
