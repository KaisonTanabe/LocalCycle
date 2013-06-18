# Load the rails application
require File.expand_path('../application', __FILE__)


###################################
####### THEMEABLE OVERRIDES #######
###################################

TEST_DATA = false
DEFAULT_PER_PAGE = 20

SUPPORT_EMAIL = "info@localcycle.org"


IMAGE_STYLES = {large: "600x400>", medium: "240x160>", thumb: "60x40>"}
DEFAULT_PAPERCLIP_IMAGE = "/images/:style/missing.png"

###################################
## DISPLAY
GENDER = {
  "Male" => "male",
  "Female" => "female"
}

ROLES = {
  "admin" => "Admin",
  "buyer" => "Buyer",
  "producer" => "Producer"
}
SIZES = {
  0 => "Small",
  1 => "Medium",
  2 => "Large"
}
DISTANCES = {
  20 => "20 miles",
  50 => "50 miles",
  100 => "100 miles",
  250 => "250 miles"
}
REGISTERABLE_ROLES = {
  "buyer" => "Buyer",
  "producer" => "Producer"
}

FREQUENCIES = {
  "daily" => "Daily",
  "weekly" => "Weekly",
  "monthly" => "Monthly"
}

WEEKDAYS = {
  1 => "Mon",
  2 => "Tues",
  3 => "Wed",
  4 => "Thurs",
  5 => "Fri",
  6 => "Sat",
  7 => "Sun",
}
NORMAL_HOURS = {
#  1 => "1am",
#  2 => "2am",
#  3 => "3am",
#  4 => "4am",
#  5 => "5am",
#  6 => "6am",
#  7 => "7am",
  8 => "8 am",
  9 => "9 am",
  10 => "10 am",
  11 => "11 am",
  12 => "Noon",
  13 => "1 pm",
  14 => "2 pm",
  15 => "3 pm",
  16 => "4 pm",
  17 => "5 pm",
  18 => "6 pm",
#  19 => "7pm",
#  20 => "8pm",
#  21 => "9pm",
#  22 => "10pm",
#  23 => "11pm",
#  0 => "Midnight",
}

GROWING_METHODS = {
  0 => "Custom",
  1 => "Responsible",
  2 => "Green",
  3 => "Organic",
  4 => "Biodynamic"
}

AGREEMENT_TYPES = {
  "onetime" => "One Time",
  "seasonal" => "Seasonal",
  "indefinite" => "Indefinite",  
}


UNIT_TYPE = {
  "lb" => "Pound",
#  "3lb" => "3 Pounds",
#  "5lb" => "5 Pounds",
#  "10lb" => "10 Pounds",
#  "15lb" => "15 Pounds",
#  "20lb" => "20 Pounds",
#  "25lb" => "25 Pounds",
  "bunch" => "Bunch",
  "bu" => "Bushel",
  "1/2bu" => "Half Bushel",
  "4/5bu" => "4/5 Bushel",
  "case" => "Case",
  "doz" => "Dozen",
  "ea" => "Single",
  "flat" => "Flat",
  "gal" => "Gallon",
  "1/2gal" => "Half Gallon",
  "pack" => "Pack",
  "piece" => "Piece",
  "pt" => "Pint",
  "1/2pt" => "Half Pint",
  "wheel" => "Wheel",
  "1/2wheel" => "Half Wheel",
  "1/4wheel" => "Quarter Wheel"
}

###################################


###################################
## MODULE 

###################################


###################################
## EMAIL
ADDITIONAL_ADMINS = ["Macklin Chaffee <macklin@goldenorbventure.com>"]
REPLY_TO_ADDRESS = ["LocalCycle Support <info@localcycle.org>"]
###################################


# Initialize the rails application
LOCALCYCLE::Application.initialize!
