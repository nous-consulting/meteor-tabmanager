Package.describe({
  name: 'nous:tabmanager',
  version: '0.2',
  summary: 'Virtual (browser like) tabs manager for Meteor apps.',
  git: 'https://github.com/nous-consulting/meteor-tabmanager',
  documentation: null
});

Package.onUse(function(api) {
  api.versionsFrom('1.1.0.2');
  api.use('templating@1.0.0');
  api.use('coffeescript');
  api.use('nous:state');
  api.export('TabManager');
  api.addFiles('tabmanager.coffee');
});

Package.onTest(function(api) {
  api.use('tinytest');
  api.use('nous:tabmanager');
  api.addFiles('tabmanager-tests.js');
});
