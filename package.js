Package.describe({
  name: 'nous:tabmanager',
  version: '0.5.0',
  summary: 'Menu/tabs with persistent state support for Meteor apps.',
  git: 'https://github.com/nous-consulting/meteor-tabmanager',
  documentation: 'README.md'
});

Package.onUse(function(api) {
  api.versionsFrom('1.1.0.2');
  api.use('templating');
  api.use('blaze');
  api.use('coffeescript');
  api.use('reactive-var');
  api.use('nous:state@0.7.0');
  api.use('nous:utils-and-helpers@0.4.3');
  api.addFiles([
    'client/open-tabs.html',
    'client/open-tabs.coffee'
    ], 'client');
  api.addFiles('tabmanager.coffee');
  api.export('TabManager');
});

Package.onTest(function(api) {
  api.use('tinytest');
  api.use('nous:tabmanager');
  api.addFiles('tabmanager-tests.js');
});
