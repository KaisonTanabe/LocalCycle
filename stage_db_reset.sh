#!/bin/bash

heroku pg:reset DATABASE_URL --app lcstaging --confirm lcstaging
heroku run rake db:migrate
heroku run rake db:seed