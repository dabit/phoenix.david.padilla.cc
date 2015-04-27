exports.config = {
  // See http://brunch.io/#documentation for docs.
  files: {
    javascripts: {
      joinTo: 'js/app.js',
      order: {
        before: [
          'web/static/vendor/jquery-2.1.3.js',
          'web/static/vendor/bootstrap.js'
        ]
      }
    },
    stylesheets: {
      joinTo: {
        'css/app.css': [
          'web/static/vendor/bootstrap.css',
          /\/app\//
         ],
        'css/admin.css': [
          'web/static/vendor/bootstrap.css',
          /\/admin\//
        ]
      },
      order: {
        before: [
          'web/static/vendor/bootstrap.css'
        ]
      }
    },
    templates: {
      joinTo: 'js/app.js'
    }
  },

  // Phoenix paths configuration
  paths: {
    // Which directories to watch
    watched: ["web/static", "test/static"],

    // Where to compile files to
    public: "priv/static"
  },

  // Configure your plugins
  plugins: {
    ES6to5: {
      // Do not use ES6 compiler in vendor code
      ignore: [/^(web\/static\/vendor)/]
    }
  }
};
