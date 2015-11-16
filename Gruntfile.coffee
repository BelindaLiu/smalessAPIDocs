module.exports = (grunt)->
  grunt.initConfig

    watch:
      scripts:
        files: ['src/**/*.jade','src/scss/*.scss']
        tasks: ['default']
      options:
        spawn: false
        debounceDelay: 300

    sass:
      demo:
        files:
          'main.css':'src/scss/main.scss'

    coffee:
      demo:
        files:
          "main.js": "src/coffee/forDoc.coffee"

    jade:
      demo:
        options:
          data:
            debug: true,
            timestamp: "<%= new Date().getTime() %>"
        files:
          "index.html": "src/index.jade"

    shell:
      installSASS:
        command: 'sudo gem install sass'
      installJADE:
        command: 'sudo npm install jade -g'
      concatScss:
        command: 'node concatSass.js'

    copy:
      packages:
        src: ['bower_components/**/*']
        dest: 'output'
        expand: true
      build:
        cwd: 'src'
        src: 'scss/lib/images/*'
        dest: 'output'
        expand: true

  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-shell'
  grunt.loadNpmTasks 'grunt-contrib-sass'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-jade'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-copy'

  grunt.registerTask "buildEnv", ["shell:installSASS", "shell:installJADE"]
  grunt.registerTask "build", ["shell:concatScss", "sass", "coffee:demo", "jade:demo", "copy:build","copy:packages"]
  grunt.registerTask "default", ["build"]
