# Load the rails application
require File.expand_path('../application', __FILE__)


###################################
####### THEMEABLE OVERRIDES #######
###################################

TEST_DATA = false
DEFAULT_PER_PAGE = 50

SUPPORT_EMAIL = "support@localcycle.org"

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


GROWING_METHODS = {
  "responsible" => "Responsible",
  "green" => "Green",
  "organic" => "Organic",
  "biodynamic" => "Biodynamic"
}

PRODUCER_CERTIFICATIONS = {
  "00" => "Animal Welfare Approved",
  "01" => "Certified Humane",
  "02" => "Food Alliance",
  "03" => "HCAAP",
  "04" => "USDA Gap Food Safety Certified",
  "05" => "Beyond Organic",
  "06" => "Certified Naturally Grown",
  "07" => "The Farmer's Pledge",
}
LIVESTOCK_CERTIFICATIONS = {
  "20" => "100% Grass Fed",
  "21" => "Cage Free/Free Roaming/Crate Free ",
  "22" => "Animal Welfare",
  "23" => "Grass Fed, Grain Finished",
  "24" => "Halal",
  "25" => "Kosher",
  "26" => "Nitrate Free",
  "27" => "Pasture Raised",
  "28" => "Vegetarian Fed",
}
EGG_CERTIFICATIONS = {
  "40" => "Cage-Free Hens/Free Roaming Hens",
  "41" => "Pasture Raised Hens",
  "42" => "Vegetarian Fed",
}
DAIRY_CERTIFICATIONS = {
  "50" => "Cheeses aged for 60+ days",
  "51" => "Homogenized",
}
PANTRY_CERTIFICATIONS = {
  "60" => "Certified Vegan",
  "61" => "DOHMH Food Safety Certified",
  "62" => "No artificial additives",
  "63" => "USDA Approved Processing Plants",
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
  "ea" => "Each",
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
REPLY_TO_ADDRESS = ["LocalCycle Support <support@localcycle.org>"]
###################################


# Initialize the rails application
LOCALCYCLE::Application.initialize!
