#　build develop environment after clone our project
env:
	rm -rf node_modules
	npm install
	rm -rf bower_components
	bower install
	sudo gem install sass
	sudo npm install jade -g

# build output files by grunt
# you can modify Gruntfile.coffee to change tasks
build:
	# clear old output files
	rm -f src/main.scss
	rm -f main.css
	rm -rf sassDoc
	grunt
