exports.config = {
  // See http://brunch.io/#documentation for docs.
  files: {
    javascripts: {
      joinTo: 'js/app.js'
    },
    stylesheets: {
      joinTo: 'css/app.css'
    },
    templates: {
      joinTo: 'js/app.js'
    }
  },

  conventions: {
    // This option sets where we should place non-css and non-js assets in.
    // By default, we set this to '/assets/static'. Files in this directory
    // will be copied to `paths.public`, which is 'priv/static' by default.
    assets: /^(static)/
  },

  // Phoenix paths configuration
  paths: {
    // Dependencies and current project directories to watch
    watched: ['static', 'css', 'js', 'vendor', 'scss'],
    // Where to compile files to
    public: '../priv/static'
  },

  // Configure your plugins
  plugins: {
    babel: {
      babelrc: true
    },
    copycat: {
      'fonts': [
        'node_modules/font-awesome/fonts'
      ]
    },
    sass: {
      options: {
        includePaths: [
          'node_modules/font-awesome/scss',
          'node_modules/bootstrap/scss'
        ], // Tell sass-brunch where to look for files to @import
        precision: 8 // Minimum precision required by bootstrap-sass
      }
    }
  },

  modules: {
    autoRequire: {
      'js/app.js': ['js/app']
    }
  },

  npm: {
    enabled: true,
    globals: { // Bootstrap's JavaScript requires both '$' and 'jQuery' in global scope
      $: 'jquery',
      jQuery: 'jquery',
      Tether: 'tether',
      bootstrap: 'bootstrap' // Require Bootstrap's JavaScript globally
    }
  }
};
