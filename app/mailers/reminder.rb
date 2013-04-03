class Reminder < ActionMailer::Base

  reply_to = REPLY_TO_ADDRESS

  default from: reply_to
  default reply_to: reply_to

  def review_prompt(form)
    @form = form
    to_string = User.reviewers.map {|u| u.full_name + "<" + u.email + ">"}
    mail to: to_string, subject: "Form Submitted for Review"
  end

  def resubmission_prompt(form)
    @form = form
    to_string = User.reviewers.denied_form(form.id).map {|u| u.full_name + "<" + u.email + ">"}
    @form.form_reviews.denied.destroy_all
    @form.update_no_vote_count
    mail to: to_string, subject: "Form Resubmitted for Review"
  end

  def reviewed_prompt(form)
    @form = form
    mail to: @form.user.full_name + "<" + @form.user.email + ">", subject: "Form Reviewed"
  end
  

end
