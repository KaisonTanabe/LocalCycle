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
ACREAGE = {
  0 => "Small: 0-10",
  1 => "Medium: 10-50",
  2 => "Large: 50+"
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
  8 => "8am",
  9 => "9am",
  10 => "10am",
  11 => "11am",
  12 => "Noon",
  13 => "1pm",
  14 => "2pm",
  15 => "3pm",
  16 => "4pm",
  17 => "5pm",
  18 => "6pm",
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
GROWING_METHODS_TEXT = {
  0 => 'Custom',
  1 => '<strong style="color: #8bc63e;">Responsible</strong> Farms have a reverence for the ecological and social wellbeing of local communities. Many employ conventional farming methods, but go a step beyond industrial agriculture.</label>
  <ul>
    <li>All produce farms must utilize Integrated Pest Management and crop rotation at a minimum, and be GMO-free.</li>
    <li>All livestock farmers must not be CAFOs, must treat animals humanely, must raise animals that are hormone-free, and must avoid the use of antibiotics.</li>
    <li>All mid to large sized farms on LocalCycle must employ worker safety systems to ensure quality of work life for all employees.</li>
  </ul>
  <small>If your farm goes beyond these basic requirements but is not certified organic, see <em>Green</em> label.</small>',
  2 => '<strong style="color: #60ac37;">Green</strong> farms go beyond <em>Responsible</em>, additionally meeting several requirements of organic farming without being organic certified. Green Farms do not employ synthetic pesticides nor chemical fertilizers.',
  3 => '<strong style="color: #39b54a;">Organic (certified)</strong> food is produced without antibiotics, growth hormones, conventional pesticides, petroleum-based fertilizers or sewage sludge-based fertilizers, bioengineering, or ionizing radiation. U.S. Department of Agriculture (USDA) certification is required before a product can be labeled "organic."',
  4 => '<strong style="color: #146527;">Biodynamic (certified)</strong> agriculture considers both the material and spiritual context of food production and works with terrestrial as well as cosmic influences. The influence of planetary rhythms on the growth of plants and animals, in terms of the ripening power of light and warmth, is managed by guiding cultivation times with an astronomical calendar. All organic principles apply to biodynamic farming.'
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
