Template.openTabs.helpers
  state: -> 'active' if @url is Session.get 'currentTab'
  tabs: (tabManager) ->
    Tabs.find().map (tab) ->
      tab.icon = tabManager.getIcon(tab.route)
      return tab

Template.openTabs.events
  'click .close-tab': (e) ->
    e.preventDefault()
    if @url is Session.get 'currentTab'
      FlowRouter.go('dashboard')
    Tabs.remove @_id
