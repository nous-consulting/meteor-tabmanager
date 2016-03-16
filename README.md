This package helps to create Tab based navigation and with persist your state (all tree) into database each time URL is changed. For reactive state vars we use [`nous:state`](https://atmospherejs.com/nous/state).

## Installation

    `meteor add nous:tabmanager`

## Usage

In your collection.js do:

```JavaScript
Tabs = new Mongo.Collection('tabs');

icons = {
  routeName: 'fa-dashboard',
  secondRouteName: 'fa-inbox',
  ...
}

tabManager = new TabManager(Tabs, icons);
```

In your router.js do:

```JavaScript
Router.onBeforeAction( function() {
  title = 'name for my route';
  tabManager.createTab(this.route.getName(), title);
});

```

Now you have Tabs colletion where you have stored tabs and states.

In your template you can use `openTabs` template and provide there you tabManager. Put it inside `<ul>`:

```Html
<template name="my_header">
  ...
  <ul>
  {{> openTabs tabManager=tabManager}}
  </ul>
  ...
</template>
```


## Example

### Template

```Jade
template(name="header")
  .nav.navbar.navbar-fixed-top.navbar-default(role="navigation")
    .navbar-header
      a.navbar-brand(href="{{pathFor 'dashboard'}}")
        img(src="logo.png")
      button.navbar-toggle.collapsed(type="button",data-toggle="collapse",data-target=".navbar-collapse")
        span.sr-only Toggle navigation
        span.icon-bar
        span.icon-bar
        span.icon-bar
    .navbar-collapse.collapse
      ul.nav.navbar-nav
        +openTabs tabManager=tabManager
```

### Helpers
```JavaScript
Template.header.helpers({
  tabManager: function () {
    return tabManager
  }
});
```



!!! Don't forget `Template.myname.initState` if you want use and persist state vars. For more information how to use states: https://atmospherejs.com/nous/state