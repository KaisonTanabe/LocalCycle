desc "Send automatic notices/reminders to parents concerning student's physical form expiration"
task :physical_reminders => :environment do
  puts "Sending automatic notices/reminders to parents concerning student's physical form expiration..."
  
  # Iterate through Students. Check physicals
  Student.scoped.active_only.each do |s|
    days = (s.form.exp_date - Date.today).to_i

    # SEND reminder to parents if phyical expiration approaching or happened
    if (PHYSICAL_REMINDER_DAYS.include?(days))
      puts "EMAILING: " + s.full_name + "'s parents"
      PhysicalReminder.soon(s).deliver
    elsif (PHYSICAL_EXPIRED_DAYS.include?(days))
      puts "EMAILING: " + s.full_name + "'s parents"
      PhysicalReminder.expired(s).deliver
    end
  end

  puts "Done physical_reminders."
end



desc "Send list of ineligible students to admins"
task :ineligible_student_list => :environment do
#  if Time.now.monday?
    puts "Sending list of ineligible students to admins..."
    
    # SEND list of ineligible students to admin
    ineligible_students = []
    Student.includes(:form).each do |s|
      ineligible_students << s if s.form.is_ineligible
    end
    
    PhysicalReminder.ineligible_list(ineligible_students).deliver
    
    puts "Done ineligibility_statement."
#  end
end


desc "Send coaches their roster"
task :roster_status => :environment do
  puts "Sending coaches their roster..."
  
  # Iterate through Students. Check physicals
  Team.all.each do |t|

    # SEND reminder to parents if phyical expiration approaching or happened
    PhysicalReminder.roster(t).deliver

  end

  puts "Done physical_reminders."
end




###########
## TESTS ##
###########

desc "Send test physical change email to parents"
task :physical_update => :environment do
  puts "Sending test physical change email to parents..."

  # SEND reminder to parents if phyical expiration approaching or happened
  PhysicalReminder.updated(Student.first).deliver

  puts "Done physical_update."
end


desc "Send test prompt to student"
task :prompt_student_login => :environment do
  puts "Sending test prompt to student..."

  # SEND reminder to parents if phyical expiration approaching or happened
  SignaturesNeeded.prompt_student_sig(Student.where(email: "theelements05@hotmail.com").first).deliver

  puts "Done prompt_student_login."
end


task
