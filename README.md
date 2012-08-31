## Valency Online 

This is the code repository for the Rails app that will present the Leipzig Valency Classes Project's data as an searchable interactive online resource.

[Changelog](https://github.com/fanaugen/valency/blob/master/CHANGELOG.md)

### Description of Contents

The default directory structure of a generated Ruby on Rails application:

	|-- app
	|   |-- assets
	|       |-- images
	|       |-- javascripts
	|       `-- stylesheets
	|   |-- controllers
	|   |-- helpers
	|   |-- mailers
	|   |-- models
	|   `-- views
	|       `-- layouts
	|-- config
	|   |-- environments
	|   |-- initializers
	|   `-- locales
	|-- db
	|-- doc
	|-- lib
	|   `-- tasks
	|-- log
	|-- public
	|-- script
	|-- test
	|   |-- fixtures
	|   |-- functional
	|   |-- integration
	|   |-- performance
	|   `-- unit
	|-- tmp
	|   |-- cache
	|   |-- pids
	|   |-- sessions
	|   `-- sockets
	`-- vendor
		  |-- assets
			  `-- stylesheets
		  `-- plugins

*app* <br/>
  Holds all the code that's specific to this particular application.

*app/assets* <br/>
  Contains subdirectories for images, stylesheets, and JavaScript files.

*app/controllers* <br/>
  Holds controllers that should be named like weblogs_controller.rb for
  automated URL mapping. All controllers should descend from
  ApplicationController which itself descends from ActionController::Base.

*app/models* <br/>
  Holds models that should be named like post.rb. Models descend from
  ActiveRecord::Base by default.

*app/views* <br/>
  Holds the template files for the view that should be named like
  weblogs/index.html.erb for the WeblogsController#index action. All views use
  eRuby syntax by default.

*app/views/layouts* <br/>
  Holds the template files for layouts to be used with views. This models the
  common header/footer method of wrapping views. In your views, define a layout
  using the <tt>layout :default</tt> and create a file named default.html.erb.
  Inside default.html.erb, call `<% yield %>` to render the view using this
  layout.

*app/helpers* <br/>
  Holds view helpers that should be named like weblogs_helper.rb. These are
  generated for you automatically when using generators for controllers.
  Helpers can be used to wrap functionality for your views into methods.

*config* <br/>
  Configuration files for the Rails environment, the routing map, the database,
  and other dependencies.

*db* <br/>
  Contains the database schema in schema.rb. db/migrate contains all the
  sequence of Migrations for your schema.

*doc* <br/>
  This directory is where your application documentation will be stored when
  generated using <tt>rake doc:app</tt>

*lib* <br/>
  Application specific libraries. Basically, any kind of custom code that
  doesn't belong under controllers, models, or helpers. This directory is in
  the load path.

*public* <br/>
  The directory available for the web server. Also contains the dispatchers and the
  default HTML files. This should be set as the DOCUMENT_ROOT of your web
  server.

*script* <br/>
  Helper scripts for automation and generation.

*test* <br/>
  Unit and functional tests along with fixtures. When using the rails generate
  command, template test files will be generated for you and placed in this
  directory.

*vendor* <br/>
  External libraries that the application depends on. Also includes the plugins
  subdirectory. If the app has frozen rails, those gems also go here, under
  vendor/rails/. This directory is in the load path.
