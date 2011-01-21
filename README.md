SpreeAdminTasks
===============

AdminTasks are little reminders for oneself, or other team members to "do something".

They have a date, a done? state and the task (text). Also an object may be attached, and Orders and Products are supported. If you want others, you'll need to create the appropriate links yourself.

A Task is assigned to an admin user.

Also the default landing page is changed to the task overview, with the reasoning that if you have so many people that you need to assign tasks, they won't all be so interested in your performance all the time.

Installation
=======

Add to your Gemfile with 

  gem "spree_admin_tasks", :git => "git://github.com/dancinglightning/spree-admin-tasks.git"

and run bundler.

There is a migration, so you will have to move it with 
  
  rake spree_admin_tasks:install 
  
before rails3 and then run it with 

  rake db:migrate



Copyright (c) 2011 [Torsten Rüger], released under the New BSD License
