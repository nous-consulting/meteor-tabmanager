Package.describe({
  name: 'nous:tabmanager',
  version: '0.4.0',
  summary: 'Virtual (browser like) tabs manager for Meteor apps.',
  git: 'https://github.com/nous-consulting/meteor-tabmanager',
  documentation: 'README.md'
});

Package.onUse(function(api) {
  api.versionsFrom('1.1.0.2');
  api.use('templating');
  api.use('blaze');
  api.use('coffeescript');
  api.use('nous:state@0.7.0');
  api.addFiles([
    'src/open-tabs.html',
    'src/open-tabs.coffee'
    ], 'client');
  api.addFiles('tabmanager.coffee');
  api.export('TabManager');
});

Package.onTest(function(api) {
  api.use('tinytest');
  api.use('nous:tabmanager');
  api.addFiles('tabmanager-tests.js');
});
