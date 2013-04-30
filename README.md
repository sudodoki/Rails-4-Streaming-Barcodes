Rails-4-Streaming-Barcodes
==========================

Rails 4 app streaming server events using ActionController::Live and redis pub/sub mechanism for database of barcodes added by users.

In order to run this app, you should consider installing and running

* redis

* ```memcached -l localhost``` (dalli is used for session storage and it's not so good at connecting to 127.0.0.1, but localhost seems to be just fine)

* ruby version 2.0.0

* ```rake db:create db:migrate db:seed``` or ```rake db:setup```

And yes, this app uses postgres and final_task_#{environment} names for db and not database.yml.sample, because I'm lazy.