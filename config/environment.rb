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
REGISTERABLE_ROLES = {
  "buyer" => "Buyer",
  "producer" => "Producer"
}

FREQUENCIES = {
  "weekly" => "Weekly",
  "monthly" => "Monthly"
}


GROWING_METHODS = {
  "responsible" => "Responsible",
  "green" => "Green",
  "organic" => "Organic",
  "biodynamic" => "Biodynamic",
  "custom" => "Custom"
}

AGREEMENT_TYPES = {
  "onetime" => "One Time",
  "seasonal" => "Seasonal",
  "indefinite" => "Indefinite",  
}


UNIT_TYPE = {
  "lb" => "Pound",
  "3lb" => "3 Pounds",
  "5lb" => "5 Pounds",
  "10lb" => "10 Pounds",
  "15lb" => "15 Pounds",
  "20lb" => "20 Pounds",
  "25lb" => "25 Pounds",
  "bunch" => "Bunch",
  "bu" => "Bushel",
  "(1/2bu)" => "Half Bushel",
  "(4/5bu)" => "4/5 Bushel",
  "case" => "Case",
  "doz" => "Dozen",
  "ea" => "Single",
  "flat" => "Flat",
  "gal" => "Gallon",
  "(1/2gal)" => "Half Gallon",
  "pack" => "Pack",
  "piece" => "Piece",
  "pt" => "Pint",
  "(1/2pt)" => "Half Pint",
  "wheel" => "Wheel",
  "(1/2wheel)" => "Half Wheel",
  "(1/4wheel)" => "Quarter Wheel"
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
