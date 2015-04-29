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
        each tabs
          unless isDefaultTab url
            li(class=state)
              a(href=url)
                i.fa(class=icon)
                span= title
```

### Helpers
```JavaScript
Template.header.helpers({
  tabs: function () {
    Tabs.find().map(function (tab) {
      tab.icon = tabManager.getIcon(tab.route);
    });
  }
});
```



!!! Don't forget `Template.myname.initState` if you want use and persist state vars. For more information how to use states: https://atmospherejs.com/nous/state