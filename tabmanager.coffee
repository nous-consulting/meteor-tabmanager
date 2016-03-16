defaultTabUrls = ['/', '/orders', '/directory', '/suppliers']

if Meteor.isClient
  Template.registerHelper "isDefaultTab", (url) -> url in defaultTabUrls


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

    key = "#{Meteor.userId()}:#{url}"
    if @collection.find(key).count() is 0
      @collection.insert
        _id: key
        url: url
        title: title
        route: template_name

    @registerTemplate template_name

  getIcon: (route) -> @icons[route] ? 'fa-file'
