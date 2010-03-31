class Mailer < ActionMailer::Base

  def send_spot_map_by_mail(spot)
    @subject    = 'WebNameCard Map send service'
    @body["spot"] = spot
    @recipients = $user_email_cell
    @from       = 'info@spa.fsr.jp'
#    @sent_on    = sent_at
#    @headers    = {}
  end

  def notice_to_checker(review)
    @subject    = _('rainbow book club notice to checker1')
    @body["review"] = review
    @recipients = $user_email_cell
    @from       = 'info@spa.fsr.jp'
#    @sent_on    = sent_at
#    @headers    = {}
  end

  def notice_to_comment_checker(review_comment)
    @subject    = _('rainbow book club notice to comment checker1')
    @body["review_comment"] = review_comment
    @recipients = $user_email_cell
    @from       = 'info@spa.fsr.jp'
#    @sent_on    = sent_at
#    @headers    = {}
  end

  def notice_shopitem_to_admin_and_teachar(shopitem)
    @subject    = _('rainbow book club notice to shopitem checker')
    @body["shopitem"] = shopitem
    @recipients = $teachar_email_pc + "," + $admin_email_pc
    @from       = 'info@spa.fsr.jp'
#    @sent_on    = sent_at
#    @headers    = {}
  end

  def notice_shop_to_admin(shop)
    @subject    = _('rainbow book club notice to shop checker1')
    @body["shop"] = shop
    @recipients = $teachar_email_pc + "," + $admin_email_pc
    @from       = 'info@spa.fsr.jp'
#    @sent_on    = sent_at
#    @headers    = {}
  end


  def send_mail_form1_to_admin(mail_form1)
    @subject    = _('rainbow book club inquiry mail to admin1')
    @body["mail_form1"] = mail_form1
    @recipients = $admin_email_pc
    @from       = 'info@spa.fsr.jp'
#    @sent_on    = sent_at
#    @headers    = {}
  end

  def send_mail_form2_to_admin(mail_form2)
    @subject    = _('rainbow book club application mail to admin1')
    @body["mail_form2"] = mail_form2
    @recipients = $admin_email_pc
    @from       = 'info@spa.fsr.jp'
#    @sent_on    = sent_at
#    @headers    = {}
  end
  
#  def confirm(order)
#    @subject    = 'Pragmatic Store Order Confirmation'
#    @body["order"] = order
#    @recipients = order.email
#    @from       = 'info@spa.fsr.jp'
#    @sent_on    = sent_at
#    @headers    = {}
#  end




end
