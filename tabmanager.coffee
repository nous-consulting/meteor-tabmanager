defaultTabUrls = ['/', '/orders', '/directory', '/suppliers']

if Meteor.isClient
  Template.registerHelper "isDefaultTab", (url) -> url in defaultTabUrls


last_visited_tabs = ReactiveVar []
visitTab = (url) ->
  tabs = last_visited_tabs.get()
  if url in tabs
    tabs.remove(url)
  tabs.push url
  last_visited_tabs.set tabs

class TabManager
  constructor: (@collection, @icons) ->
    @registeredTemplates = []

  registerTemplate: (name) ->
    if name and name not in @registeredTemplates
      @registeredTemplates.push name
      collection = @collection
      getKey = ->
        if FlowRouter
          url = FlowRouter.current().path
        else
          url = Iron.Location.get().path
        key = "#{Meteor.userId()}:#{url}"

      # Register hook which will save state into database each time it will change.
      # Hook is provided by `nous:state` package.
      Template[name].onStateUpdated ->
        key = getKey()
        collection.update key, $set: state: @state.toJSON()

      # Register hook which will restore saved state from database.
      Template[name].onStateRequested ->
        key = getKey()
        collection.findOne(key)?.state

  createTab: (template_name, title) ->
    if FlowRouter
      url = FlowRouter.current().path
    else
      url = Iron.Location.get().path
    Session.set 'currentTab', url
    visitTab(url)

    key = "#{Meteor.userId()}:#{url}"
    if @collection.find(key).count() is 0
      @collection.insert
        _id: key
        url: url
        title: title
        route: template_name

    @registerTemplate template_name

  removeTab: (id) ->
    visited_tabs = last_visited_tabs.get()
    tab = @collection.findOne(id)
    if tab
      @collection.remove id
      visited_tabs.remove tab.url
      last_visited_tabs.set visited_tabs

  lastVisitedTab: ->
    tabs = last_visited_tabs.get()
    tabs[tabs.length - 1]

  getIcon: (route) -> @icons[route] ? 'fa-file'
