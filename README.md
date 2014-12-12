skeleton_ruby
=============

A bare bones ruby application providing you with basics like gem management, configuration, logging, testing and data storage.

Why?
----

Most applications I write in ruby, from little cron jobs and command line tools, to bigger more complex applications, all have some similar basic requirements. They all give or take need:

* Configuration (Ruby's built in OpenStruct)
* Data storage (ActiveRecord gem with all Rake tasks available)
* Directory structure/file organisation (The usual ruby style)
* Gem management (Bundler)
* Logging (Ruby's built in Logger)
* Tasks (Rake gem)
* Testing (Ruby's built in MiniTest)

Skeleton ruby provides a starter application that already has all of this, so you don't need to repeat it when you start a new application. Go nuts ripping out and swapping anything it comes with, afterall, it is just a straight forward and basic ruby application. There's no magic here. 

Installation
------------

Clone the application
```bash
$ git clone https://github.com/dyson/skeleton_ruby.git my_app
```

Remove the git directory and initialise
```bash
$ cd my_app
$ rm -rf .git
$ git init
```

Review/modify the Gemfile and install
```bash
$ bundle install --path=vendor/bundler
```

Run the rename rake task (requires find, xargs, rename and sed) passing in your applications module name (CamelCase)

```bash
$ bundle exec rake rename['MyApp']
```

This will rename the skeleton_ruby files, references in files to skeleton_ruby and also the SkeletonRuby module appropriately.

Usage
-----
Having a quick look through the source code and running the below commands should provide you an idea of what is available and how it joins together.

Included rake tasks
```bash
$ bundle exec rake 
rake db:create                # Creates the database from DATABASE_URL or config/database.yml for ...
rake db:drop                  # Drops the database from DATABASE_URL or config/database.yml for th...
rake db:fixtures:load         # Load fixtures into the current environment's database
rake db:migrate               # Migrate the database (options: VERSION=x, VERBOSE=false, SCOPE=blog)
rake db:migrate:status        # Display status of migrations
rake db:rollback              # Rolls the schema back to the previous version (specify steps w/ ST...
rake db:schema:cache:clear    # Clear a db/schema_cache.dump file
rake db:schema:cache:dump     # Create a db/schema_cache.dump file
rake db:schema:dump           # Create a db/schema.rb file that is portable against any DB support...
rake db:schema:load           # Load a schema.rb file into the database
rake db:seed                  # Load the seed data from db/seeds.rb
rake db:setup                 # Create the database, load the schema, and initialize with the seed...
rake db:structure:dump        # Dump the database structure to db/structure.sql
rake db:version               # Retrieves the current schema version number
rake rename[new_module_name]  # Rename MyApp modules and my_app files/directories
rake test                     # Run tests
```

Some basic tests under the `test` folder
```bash
$ bundle exec rake test
Run options: --seed 29770

# Running:

...

Finished in 0.004737s, 633.3162 runs/s, 633.3162 assertions/s.

3 runs, 3 assertions, 0 failures, 0 errors, 0 skips
```

Example migration under `db/migrate`
```bash
$ bundle exec rake db:migrate
== 1 Schema: migrating ========================================================
-- create_table(:users, {:force=>true})
   -> 0.0026s
== 1 Schema: migrated (0.0027s) ===============================================
```

Running the included `app.rb` under `lib/skeleton_ruby` via the executable in `bin`
```bash
$ bundle exec bin/skeleton_ruby 
#<OpenStruct something="something">
Running application
User Saved
```

License
-------

MIT.
