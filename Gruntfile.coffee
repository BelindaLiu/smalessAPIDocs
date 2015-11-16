module.exports = (grunt)->
  grunt.initConfig

    watch:
      scripts:
        files: ['demo/**/*.jade','demo/scss/*.scss']
        tasks: ['default']
      options:
        spawn: false
        debounceDelay: 300
    clean:
      demo: ['output']

    concat:
      dist:
        src: [
         'demo/scss/*.scss'
        ]
        dest: 'demo/scss/main.scss'
    sass:
      dist:
        files:
          'main.css':'demo/scss/main.scss'
    coffee:
      demo:
        expand: true,
        cwd: 'demo/coffee',
        src: ['*.coffee'],
        dest: 'output/js',
        ext: '.js'

    jade:
      demo:
        options:
          data:
            debug: true,
            timestamp: "<%= new Date().getTime() %>"
        files:
          "index.html": "demo/index.jade"

    shell:
      installSASS:
        command: 'sudo gem install sass'
      installJADE:
        command: 'sudo npm install jade -g'

    copy:
      packages:
        src: ['bower_components/**/*']
        dest: 'output'
        expand: true
      build:
        cwd: 'demo'
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
  grunt.loadNpmTasks 'grunt-contrib-concat'

  grunt.registerTask "buildEnv", ["shell:installSASS", "shell:installJADE"]
  grunt.registerTask "build", ["concat", "sass", "coffee:demo", "jade:demo", "copy:build","copy:packages"]
  grunt.registerTask "default", ["clean:demo", "build"]
