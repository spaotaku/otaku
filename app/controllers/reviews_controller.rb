class ReviewsController < ApplicationController
  # GET /reviews
  # GET /reviews.xml

  def index
    set_status_list
#    @reviews = Review.all

#    if keyword = params[:keyword_l_name]
#      keyword = "%" + keyword + "%"
#      conditions = ["(name like ?)"]
#      conditions = ["spots.name like ?"]
#        conditions = ["students.l_name like ?"]
#        conditions << keyword
#      @reviews = Review.find(:all, :order => 'shopitems.name DESC',
#                             :conditions => conditions, :include => [:shopitem, :item, :student])
#    end


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
      if keyword_booktitle = params[:keyword_booktitle] and keyword_booktitle != ""
         keyword_booktitle = "%" + keyword_booktitle + "%"
#         conditions << "shopitems.name like #{Student.quote_value(keyword_booktitle)}"
         conditions << "(shopitems.name like #{Student.quote_value(keyword_booktitle)} OR shopitems.genre like #{Student.quote_value(keyword_booktitle)} OR shopitems.hero like #{Student.quote_value(keyword_booktitle)} OR reviews.genre like #{Student.quote_value(keyword_booktitle)} OR reviews.hiro like #{Student.quote_value(keyword_booktitle)})"
#         conditions << "reviews.genre like #{Student.quote_value(keyword_booktitle)}"
#         conditions << "reviews.hiro like #{Student.quote_value(keyword_booktitle)}"
      end
      if category = params[:category] and category != "0"
         conditions << "items.category_id = #{Student.quote_value(category)}"
      end

      if session[:user]
      unless session[:user].level == 0
         conditions << "status = 3"
      end
      else
         conditions << "status = 3"
      end
       sql = ""
      unless conditions.empty?
        sql << %Q|(#{conditions.join(") AND (")})|
      end

#      @reviews = Review.find(:all, :order => 'shopitems.name DESC', :conditions => sql, :include => [:shopitem, :item, :student])

      @reviews = Review.paginate(:page => params[:page], :order => 'shopitems.name DESC', :per_page => 30,
                             :conditions => sql, :include => [:shopitem, :item, :student ])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @reviews }
    end
  end

  # GET /reviews/1
  # GET /reviews/1.xml


  def index_my_class_review
    set_status_list
#    @reviews = Review.all

#    if keyword = params[:keyword_l_name]
#      keyword = "%" + keyword + "%"
#      conditions = ["(name like ?)"]
#      conditions = ["spots.name like ?"]
#        conditions = ["students.l_name like ?"]
#        conditions << keyword
#      @reviews = Review.find(:all, :order => 'shopitems.name DESC',
#                             :conditions => conditions, :include => [:shopitem, :item, :student])
#    end


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
      if keyword_booktitle = params[:keyword_booktitle] and keyword_booktitle != ""
         keyword_booktitle = "%" + keyword_booktitle + "%"
         conditions << "shopitems.name like #{Student.quote_value(keyword_booktitle)}"
      end
      if category = params[:category] and category != "0"
         conditions << "items.category_id = #{Student.quote_value(category)}"
      end
       sql = ""
      unless conditions.empty?
        sql << %Q|(#{conditions.join(") AND (")})|
      end

      @reviews = Review.find(:all, :order => 'shopitems.name DESC', :conditions => ["reviews.item_id = ?", session[:user].student.item_id], :include => [:shopitem, :item, :student])
#      @reviews = Review.find(:all, :order => 'shopitems.name DESC', :conditions => ["reviews.students.users.group_id = ?", session[:user].group.id], :include => [:shopitem, :item, :student])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @reviews }
    end
  end

  def index_my_review
    set_status_list
#    @reviews = Review.all

#    if keyword = params[:keyword_l_name]
#      keyword = "%" + keyword + "%"
#      conditions = ["(name like ?)"]
#      conditions = ["spots.name like ?"]
#        conditions = ["students.l_name like ?"]
#        conditions << keyword
#      @reviews = Review.find(:all, :order => 'shopitems.name DESC',
#                             :conditions => conditions, :include => [:shopitem, :item, :student])
#    end


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
      if keyword_booktitle = params[:keyword_booktitle] and keyword_booktitle != ""
         keyword_booktitle = "%" + keyword_booktitle + "%"
         conditions << "shopitems.name like #{Student.quote_value(keyword_booktitle)}"
      end
      if category = params[:category] and category != "0"
         conditions << "items.category_id = #{Student.quote_value(category)}"
      end
       sql = ""
      unless conditions.empty?
        sql << %Q|(#{conditions.join(") AND (")})|
      end

      @reviews = Review.find(:all, :order => 'shopitems.name DESC', :conditions => ["student_id = ?",session[:user].student.id], :include => [:shopitem, :item, :student])


    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @reviews }
    end
  end

  def list_grade_k_1
    set_status_list

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
      if keyword_booktitle = params[:keyword_booktitle] and keyword_booktitle != ""
         keyword_booktitle = "%" + keyword_booktitle + "%"
#         conditions << "shopitems.name like #{Student.quote_value(keyword_booktitle)}"
         conditions << "(shopitems.name like #{Student.quote_value(keyword_booktitle)} OR shopitems.genre like #{Student.quote_value(keyword_booktitle)} OR shopitems.hero like #{Student.quote_value(keyword_booktitle)} OR reviews.genre like #{Student.quote_value(keyword_booktitle)} OR reviews.hiro like #{Student.quote_value(keyword_booktitle)})"
#         conditions << "reviews.genre like #{Student.quote_value(keyword_booktitle)}"
#         conditions << "reviews.hiro like #{Student.quote_value(keyword_booktitle)}"
      end
      if category = params[:category] and category != "0"
         conditions << "items.category_id = #{Student.quote_value(category)}"
      end


         conditions << "(students.grade = 'k' OR students.grade = '1')"

      if session[:user]
      unless session[:user].level == 0
         conditions << "status = 3"
      end
      else
         conditions << "status = 3"
      end
       sql = ""
      unless conditions.empty?
        sql << %Q|(#{conditions.join(") AND (")})|
      end

      @reviews = Review.find(:all, :order => 'shopitems.name DESC', :conditions => sql, :include => [:shopitem, :item, :student])


    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @reviews }
    end


#    @reviews = Review.find(:all, :order => 'shopitems.name DESC', :conditions => ["students.grade = ?", "k"], :include => [:shopitem, :item, :student])
  end

  def list_grade_2_3
    set_status_list
          conditions = []
      if keyword_booktitle = params[:keyword_booktitle] and keyword_booktitle != ""
         keyword_booktitle = "%" + keyword_booktitle + "%"
         conditions << "(shopitems.name like #{Student.quote_value(keyword_booktitle)} OR shopitems.genre like #{Student.quote_value(keyword_booktitle)} OR shopitems.hero like #{Student.quote_value(keyword_booktitle)} OR reviews.genre like #{Student.quote_value(keyword_booktitle)} OR reviews.hiro like #{Student.quote_value(keyword_booktitle)})"
      end
         conditions << "(students.grade = '2' OR students.grade = '3')"
      if session[:user]
      unless session[:user].level == 0
         conditions << "status = 3"
      end
      else
         conditions << "status = 3"
      end
       sql = ""
      unless conditions.empty?
        sql << %Q|(#{conditions.join(") AND (")})|
      end
      @reviews = Review.find(:all, :order => 'shopitems.name DESC', :conditions => sql, :include => [:shopitem, :item, :student])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @reviews }
    end
  end

  def list_grade_4_6
    set_status_list
          conditions = []
      if keyword_booktitle = params[:keyword_booktitle] and keyword_booktitle != ""
         keyword_booktitle = "%" + keyword_booktitle + "%"
         conditions << "(shopitems.name like #{Student.quote_value(keyword_booktitle)} OR shopitems.genre like #{Student.quote_value(keyword_booktitle)} OR shopitems.hero like #{Student.quote_value(keyword_booktitle)} OR reviews.genre like #{Student.quote_value(keyword_booktitle)} OR reviews.hiro like #{Student.quote_value(keyword_booktitle)})"
      end
         conditions << "(students.grade = '4' OR students.grade = '5' OR students.grade = '6')"
      if session[:user]
      unless session[:user].level == 0
         conditions << "status = 3"
      end
      else
         conditions << "status = 3"
      end
       sql = ""
      unless conditions.empty?
        sql << %Q|(#{conditions.join(") AND (")})|
      end
      @reviews = Review.find(:all, :order => 'shopitems.name DESC', :conditions => sql, :include => [:shopitem, :item, :student])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @reviews }
    end
  end
  def list_grade_7_9
    set_status_list
          conditions = []
      if keyword_booktitle = params[:keyword_booktitle] and keyword_booktitle != ""
         keyword_booktitle = "%" + keyword_booktitle + "%"
         conditions << "(shopitems.name like #{Student.quote_value(keyword_booktitle)} OR shopitems.genre like #{Student.quote_value(keyword_booktitle)} OR shopitems.hero like #{Student.quote_value(keyword_booktitle)} OR reviews.genre like #{Student.quote_value(keyword_booktitle)} OR reviews.hiro like #{Student.quote_value(keyword_booktitle)})"
      end
         conditions << "(students.grade = '7' OR students.grade = '8' OR students.grade = '9')"
      if session[:user]
      unless session[:user].level == 0
         conditions << "status = 3"
      end
      else
         conditions << "status = 3"
      end
       sql = ""
      unless conditions.empty?
        sql << %Q|(#{conditions.join(") AND (")})|
      end
      @reviews = Review.find(:all, :order => 'shopitems.name DESC', :conditions => sql, :include => [:shopitem, :item, :student])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @reviews }
    end
  end
  def list_grade_10_12
    set_status_list
          conditions = []
      if keyword_booktitle = params[:keyword_booktitle] and keyword_booktitle != ""
         keyword_booktitle = "%" + keyword_booktitle + "%"
         conditions << "(shopitems.name like #{Student.quote_value(keyword_booktitle)} OR shopitems.genre like #{Student.quote_value(keyword_booktitle)} OR shopitems.hero like #{Student.quote_value(keyword_booktitle)} OR reviews.genre like #{Student.quote_value(keyword_booktitle)} OR reviews.hiro like #{Student.quote_value(keyword_booktitle)})"
      end
         conditions << "(students.grade = '10' OR students.grade = '11' OR students.grade = '12')"
      if session[:user]
      unless session[:user].level == 0
         conditions << "status = 3"
      end
      else
         conditions << "status = 3"
      end
       sql = ""
      unless conditions.empty?
        sql << %Q|(#{conditions.join(") AND (")})|
      end
      @reviews = Review.find(:all, :order => 'shopitems.name DESC', :conditions => sql, :include => [:shopitem, :item, :student])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @reviews }
    end
  end

  def list_grade_13_16
    set_status_list
          conditions = []
      if keyword_booktitle = params[:keyword_booktitle] and keyword_booktitle != ""
         keyword_booktitle = "%" + keyword_booktitle + "%"
         conditions << "(shopitems.name like #{Student.quote_value(keyword_booktitle)} OR shopitems.genre like #{Student.quote_value(keyword_booktitle)} OR shopitems.hero like #{Student.quote_value(keyword_booktitle)} OR reviews.genre like #{Student.quote_value(keyword_booktitle)} OR reviews.hiro like #{Student.quote_value(keyword_booktitle)})"
      end
         conditions << "(students.grade = '13' OR students.grade = '14' OR students.grade = '15' OR students.grade = '16')"
      if session[:user]
      unless session[:user].level == 0
         conditions << "status = 3"
      end
      else
         conditions << "status = 3"
      end
       sql = ""
      unless conditions.empty?
        sql << %Q|(#{conditions.join(") AND (")})|
      end
      @reviews = Review.find(:all, :order => 'shopitems.name DESC', :conditions => sql, :include => [:shopitem, :item, :student])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @reviews }
    end
  end

  def list_grade_17
    set_status_list
          conditions = []
      if keyword_booktitle = params[:keyword_booktitle] and keyword_booktitle != ""
         keyword_booktitle = "%" + keyword_booktitle + "%"
         conditions << "(shopitems.name like #{Student.quote_value(keyword_booktitle)} OR shopitems.genre like #{Student.quote_value(keyword_booktitle)} OR shopitems.hero like #{Student.quote_value(keyword_booktitle)} OR reviews.genre like #{Student.quote_value(keyword_booktitle)} OR reviews.hiro like #{Student.quote_value(keyword_booktitle)})"
      end
         conditions << "students.grade = '17' "
      if session[:user]
      unless session[:user].level == 0
         conditions << "status = 3"
      end
      else
         conditions << "status = 3"
      end
       sql = ""
      unless conditions.empty?
        sql << %Q|(#{conditions.join(") AND (")})|
      end
      @reviews = Review.find(:all, :order => 'shopitems.name DESC', :conditions => sql, :include => [:shopitem, :item, :student])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @reviews }
    end
  end

  def list_grade_t
    set_status_list
          conditions = []
      if keyword_booktitle = params[:keyword_booktitle] and keyword_booktitle != ""
         keyword_booktitle = "%" + keyword_booktitle + "%"
         conditions << "(shopitems.name like #{Student.quote_value(keyword_booktitle)} OR shopitems.genre like #{Student.quote_value(keyword_booktitle)} OR shopitems.hero like #{Student.quote_value(keyword_booktitle)} OR reviews.genre like #{Student.quote_value(keyword_booktitle)} OR reviews.hiro like #{Student.quote_value(keyword_booktitle)})"
      end
         conditions << "students.grade = '90'"
      if session[:user]
      unless session[:user].level == 0
         conditions << "status = 3"
      end
      else
         conditions << "status = 3"
      end
       sql = ""
      unless conditions.empty?
        sql << %Q|(#{conditions.join(") AND (")})|
      end
      @reviews = Review.find(:all, :order => 'shopitems.name DESC', :conditions => sql, :include => [:shopitem, :item, :student])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @reviews }
    end
  end


  def list_author_grade_k_1
    set_status_list

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
      if keyword_booktitle = params[:keyword_booktitle] and keyword_booktitle != ""
         keyword_booktitle = "%" + keyword_booktitle + "%"
#         conditions << "shopitems.name like #{Student.quote_value(keyword_booktitle)}"
         conditions << "(shopitems.name like #{Student.quote_value(keyword_booktitle)} OR shopitems.genre like #{Student.quote_value(keyword_booktitle)} OR shopitems.hero like #{Student.quote_value(keyword_booktitle)} OR reviews.genre like #{Student.quote_value(keyword_booktitle)} OR reviews.hiro like #{Student.quote_value(keyword_booktitle)})"
#         conditions << "reviews.genre like #{Student.quote_value(keyword_booktitle)}"
#         conditions << "reviews.hiro like #{Student.quote_value(keyword_booktitle)}"
      end
      if category = params[:category] and category != "0"
         conditions << "items.category_id = #{Student.quote_value(category)}"
      end


         conditions << "(students.grade = 'k' OR students.grade = '1')"

      if session[:user]
      unless session[:user].level == 0
         conditions << "status = 3"
      end
      else
         conditions << "status = 3"
      end
       sql = ""
      unless conditions.empty?
        sql << %Q|(#{conditions.join(") AND (")})|
      end

      @reviews = Review.find(:all, :order => 'shopitems.name DESC', :conditions => sql, :include => [:shopitem, :item, :student])


    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @reviews }
    end


#    @reviews = Review.find(:all, :order => 'shopitems.name DESC', :conditions => ["students.grade = ?", "k"], :include => [:shopitem, :item, :student])
  end


  def list_author_grade_2_3
    set_status_list
          conditions = []
      if keyword_booktitle = params[:keyword_booktitle] and keyword_booktitle != ""
         keyword_booktitle = "%" + keyword_booktitle + "%"
         conditions << "(shopitems.name like #{Student.quote_value(keyword_booktitle)} OR shopitems.genre like #{Student.quote_value(keyword_booktitle)} OR shopitems.hero like #{Student.quote_value(keyword_booktitle)} OR reviews.genre like #{Student.quote_value(keyword_booktitle)} OR reviews.hiro like #{Student.quote_value(keyword_booktitle)})"
      end
         conditions << "(students.grade = '2' OR students.grade = '3')"
      if session[:user]
      unless session[:user].level == 0
         conditions << "status = 3"
      end
      else
         conditions << "status = 3"
      end
       sql = ""
      unless conditions.empty?
        sql << %Q|(#{conditions.join(") AND (")})|
      end
      @reviews = Review.find(:all, :order => 'shopitems.name DESC', :conditions => sql, :include => [:shopitem, :item, :student])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @reviews }
    end
  end
  def list_author_grade_4_6
    set_status_list
          conditions = []
      if keyword_booktitle = params[:keyword_booktitle] and keyword_booktitle != ""
         keyword_booktitle = "%" + keyword_booktitle + "%"
         conditions << "(shopitems.name like #{Student.quote_value(keyword_booktitle)} OR shopitems.genre like #{Student.quote_value(keyword_booktitle)} OR shopitems.hero like #{Student.quote_value(keyword_booktitle)} OR reviews.genre like #{Student.quote_value(keyword_booktitle)} OR reviews.hiro like #{Student.quote_value(keyword_booktitle)})"
      end
         conditions << "(students.grade = '4' OR students.grade = '5' OR students.grade = '6')"
      if session[:user]
      unless session[:user].level == 0
         conditions << "status = 3"
      end
      else
         conditions << "status = 3"
      end
       sql = ""
      unless conditions.empty?
        sql << %Q|(#{conditions.join(") AND (")})|
      end
      @reviews = Review.find(:all, :order => 'shopitems.name DESC', :conditions => sql, :include => [:shopitem, :item, :student])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @reviews }
    end
  end
  def list_author_grade_7_9
    set_status_list
          conditions = []
      if keyword_booktitle = params[:keyword_booktitle] and keyword_booktitle != ""
         keyword_booktitle = "%" + keyword_booktitle + "%"
         conditions << "(shopitems.name like #{Student.quote_value(keyword_booktitle)} OR shopitems.genre like #{Student.quote_value(keyword_booktitle)} OR shopitems.hero like #{Student.quote_value(keyword_booktitle)} OR reviews.genre like #{Student.quote_value(keyword_booktitle)} OR reviews.hiro like #{Student.quote_value(keyword_booktitle)})"
      end
         conditions << "(students.grade = '7' OR students.grade = '8' OR students.grade = '9')"
      if session[:user]
      unless session[:user].level == 0
         conditions << "status = 3"
      end
      else
         conditions << "status = 3"
      end
       sql = ""
      unless conditions.empty?
        sql << %Q|(#{conditions.join(") AND (")})|
      end
      @reviews = Review.find(:all, :order => 'shopitems.name DESC', :conditions => sql, :include => [:shopitem, :item, :student])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @reviews }
    end
  end
  def list_author_grade_10_12
    set_status_list
          conditions = []
      if keyword_booktitle = params[:keyword_booktitle] and keyword_booktitle != ""
         keyword_booktitle = "%" + keyword_booktitle + "%"
         conditions << "(shopitems.name like #{Student.quote_value(keyword_booktitle)} OR shopitems.genre like #{Student.quote_value(keyword_booktitle)} OR shopitems.hero like #{Student.quote_value(keyword_booktitle)} OR reviews.genre like #{Student.quote_value(keyword_booktitle)} OR reviews.hiro like #{Student.quote_value(keyword_booktitle)})"
      end
         conditions << "(students.grade = '10' OR students.grade = '11' OR students.grade = '12')"
      if session[:user]
      unless session[:user].level == 0
         conditions << "status = 3"
      end
      else
         conditions << "status = 3"
      end
       sql = ""
      unless conditions.empty?
        sql << %Q|(#{conditions.join(") AND (")})|
      end
      @reviews = Review.find(:all, :order => 'shopitems.name DESC', :conditions => sql, :include => [:shopitem, :item, :student])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @reviews }
    end
  end
  def list_author_grade_13_16
    set_status_list
          conditions = []
      if keyword_booktitle = params[:keyword_booktitle] and keyword_booktitle != ""
         keyword_booktitle = "%" + keyword_booktitle + "%"
         conditions << "(shopitems.name like #{Student.quote_value(keyword_booktitle)} OR shopitems.genre like #{Student.quote_value(keyword_booktitle)} OR shopitems.hero like #{Student.quote_value(keyword_booktitle)} OR reviews.genre like #{Student.quote_value(keyword_booktitle)} OR reviews.hiro like #{Student.quote_value(keyword_booktitle)})"
      end
         conditions << "(students.grade = '13' OR students.grade = '14' OR students.grade = '15' OR students.grade = '16')"
      if session[:user]
      unless session[:user].level == 0
         conditions << "status = 3"
      end
      else
         conditions << "status = 3"
      end
       sql = ""
      unless conditions.empty?
        sql << %Q|(#{conditions.join(") AND (")})|
      end
      @reviews = Review.find(:all, :order => 'shopitems.name DESC', :conditions => sql, :include => [:shopitem, :item, :student])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @reviews }
    end
  end

  def list_author_grade_17
    set_status_list
          conditions = []
      if keyword_booktitle = params[:keyword_booktitle] and keyword_booktitle != ""
         keyword_booktitle = "%" + keyword_booktitle + "%"
         conditions << "(shopitems.name like #{Student.quote_value(keyword_booktitle)} OR shopitems.genre like #{Student.quote_value(keyword_booktitle)} OR shopitems.hero like #{Student.quote_value(keyword_booktitle)} OR reviews.genre like #{Student.quote_value(keyword_booktitle)} OR reviews.hiro like #{Student.quote_value(keyword_booktitle)})"
      end
         conditions << "students.grade = '17' "
      if session[:user]
      unless session[:user].level == 0
         conditions << "status = 3"
      end
      else
         conditions << "status = 3"
      end
       sql = ""
      unless conditions.empty?
        sql << %Q|(#{conditions.join(") AND (")})|
      end
      @reviews = Review.find(:all, :order => 'shopitems.name DESC', :conditions => sql, :include => [:shopitem, :item, :student])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @reviews }
    end
  end

  def list_author_grade_t
    set_status_list
          conditions = []
      if keyword_booktitle = params[:keyword_booktitle] and keyword_booktitle != ""
         keyword_booktitle = "%" + keyword_booktitle + "%"
         conditions << "(shopitems.name like #{Student.quote_value(keyword_booktitle)} OR shopitems.genre like #{Student.quote_value(keyword_booktitle)} OR shopitems.hero like #{Student.quote_value(keyword_booktitle)} OR reviews.genre like #{Student.quote_value(keyword_booktitle)} OR reviews.hiro like #{Student.quote_value(keyword_booktitle)})"
      end
         conditions << "students.grade = '90' "
      if session[:user]
      unless session[:user].level == 0
         conditions << "status = 3"
      end
      else
         conditions << "status = 3"
      end
       sql = ""
      unless conditions.empty?
        sql << %Q|(#{conditions.join(") AND (")})|
      end
      @reviews = Review.find(:all, :order => 'shopitems.name DESC', :conditions => sql, :include => [:shopitem, :item, :student])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @reviews }
    end
  end

  def show
    set_status_list
    @review = Review.find(params[:id])
    if session[:user]
    @review_comment = ReviewComment.new
    @review_comment.review_id = @review.id
    @review_comment.student_id = session[:user].student.id
#    @review_comment.status = 1
    end
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @review }
    end
  end

  # GET /reviews/new
  # GET /reviews/new.xml

  def show_my_class_review
    set_status_list
    @review = Review.find(params[:id])
    if session[:user]
    @review_comment = ReviewComment.new
    @review_comment.review_id = @review.id
    @review_comment.student_id = session[:user].student.id
#    @review_comment.status = 1
    end
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @review }
    end
  end


  def show_my_review
    set_status_list
    @review = Review.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @review }
    end
  end

  def new
    @review = Review.new
    @review.shopitem_id = params[:shopitem_id]
    @review.student_id = session[:user].student.id
    @review.item_id = session[:user].student.item_id
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @review }
    end
  end

  # GET /reviews/1/edit
  def edit
    @review = Review.find(params[:id])
  end

  # POST /reviews
  # POST /reviews.xml

  def edit_by_teachar
    @review = Review.find(params[:id])
  end

  def edit_by_student
    @review = Review.find(params[:id])
  end

  def edit_comment_by_student
    set_status_list
    @review = Review.find(params[:id])
    @review_comment = ReviewComment.find(params[:comment_id])
    @review_comment.status = 0 if @review_comment.status >> 1
  end

  def edit_comment_by_teachar
    set_status_list
    @review = Review.find(params[:id])
    @review_comment = ReviewComment.find(params[:comment_id])
  end

  def create
#    @review = Review.new(params[:review])
    Review.transaction do
      @review = Review.new(params[:review])
#      @student.created_at = param_time()
#      @student.user_id = session[:user].id
#      @student.group_id = session[:user].group_id
#      @review.status = 1
#      @review.save!
#      save_pics
    end

#    notice_to_checker
    
    respond_to do |format|
      if @review.save
        save_pics
        notice_to_checker if @review.status == 1
        flash[:notice] = _('Review was successfully created.')
        format.html { redirect_to(:action => 'show', :id => @review) }
        format.xml  { render :xml => @review, :status => :created, :location => @review }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @review.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /reviews/1
  # PUT /reviews/1.xml

  def update
    @review = Review.find(params[:id])
    @review.update_attributes(params[:review])
    save_pics
    delete_pics

    redirect_to(:action => 'index')
#    respond_to do |format|
#      if @review.update_attributes(params[:review])
#        flash[:notice] = 'Review was successfully updated.'
#        format.html { redirect_to(@review) }
#        format.xml  { head :ok }
#      else
#        format.html { render :action => "edit" }
#        format.xml  { render :xml => @review.errors, :status => :unprocessable_entity }
#      end
#    end
  end


  def update_by_student
    @review = Review.find(params[:id])
#    @review.update_attributes(params[:review])
#    save_pics
#    delete_pics

#    notice_to_checker

#    redirect_to(:action => 'show_my_review', :id => @review)

    respond_to do |format|
      if @review.update_attributes(params[:review])
        save_pics
        delete_pics
        notice_to_checker if @review.status == 1
        flash[:notice] = _('Review was successfully updated.')
        format.html { redirect_to(:action => 'show_my_review', :id => @review) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @review.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.xml
  def destroy
    @review = Review.find(params[:id])
    @review.destroy

    respond_to do |format|
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
      @picture = @review.pictures.build
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

  def notice_to_checker
#    @teachar1 = User.find(:first, :conditions => ["group_id = ? and level = 3", session[:user].group_id]).email_pc
  #  @teachar2 = User.find(:second, :conditions => ["group_id = ? and level = 3", session[:user].group_id]).email_pc

    @teachar3 = User.find_by_sql("SELECT email_pc from users WHERE group_id  = '" + session[:user].group_id.to_s + "' and level = 3")

    #p @teachar[:email_cell]
  $user_email_cell = "info@spa.fsr.jp"
  $user_email_cell = @teachar3[0].email_pc if @teachar3[0]
  $user_email_cell = @teachar3[0].email_pc + "," + @teachar3[1].email_pc if @teachar3[1]
  $user_email_cell = @teachar3[0].email_pc + "," + @teachar3[1].email_pc + "," + @teachar3[2].email_pc if @teachar3[2]

    @review = Review.find(params[:id]) if @review == nil

    Mailer.deliver_notice_to_checker(@review)
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
