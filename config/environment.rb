# Load the rails application
require File.expand_path('../application', __FILE__)


###################################
####### THEMEABLE OVERRIDES #######
###################################

SUBDOMAIN = "cflpdc"
TEST_DATA = false

###################################
## DISPLAY
ORGANIZATION_NAME = "FinalForms Demo High School"

REPLY_TO_ADDRESS = ""

ROLES = {
  "Admin" => "admin",
  "Committee Member" => "cm",
  "Educator" => "educator"
}

REVIEW_OPTIONS = {
  "Please select..." => "pending",
  "Approve" => "approve",
  "Deny" => "deny",
}

DEFAULT_PER_PAGE = 50

GENDER = {
  "Male" => "male",
  "Female" => "female"
}
###################################


###################################
## MODULE 

###################################


###################################
## FORMS
FORM_TYPES = {
  "101A-PreApproval College Coursework-Workshops Form" => "form101a",
  "101B-Checklist for Internet-Computer Coursework" => "form101b",
#  "101C-Evaluation of Activity-College Coursework or Workshop" => "form_101c",
#  "102A-National Board Certification PreApproval" => "form_102a",
#  "102B-National Board Certification Evaluation" => "form_102b",
#  "103A-Professional Growth Options Proposal" => "form_103a",
#  "103B-Professional Growth Options Evaluation" => "form_103b",
#  "100A-Professional Development Plan Worksheet" => "form_100a",
#  "100B-Employee Profile" => "form_100b",
#  "100C-Individual Professioonal Development Plan" => "form_100c",
#  "100C-1 Measurable Evidence Examples" => "form_100c1",
#  "100D-Standards For Ohio Teachers" => "form_100d",
#  "100E-Standards For Ohio Principals" => "form_100e",
#  "100F-Professional Development Plan Review Form" => "form_100f",
}
###################################


###################################
## EMAIL
RESPONSIBLE_ADMINS = []
###################################


# Initialize the rails application
LOCALCYCLE::Application.initialize!
