Template.openTabs.helpers
  state: -> 'active' if @url is Session.get 'currentTab'
  tabs: (tabManager) ->
    Tabs.find().map (tab) ->
      tab.icon = @tabManager.getIcon(tab.route)
      return tab

Template.openTabs.events
  'click .close-tab': (e) ->
    e.preventDefault()
    tabManager = Template.parentData(0).tabManager
    tabManager.removeTab(@_id)
    if @url is Session.get 'currentTab'
      if FlowRouter
        FlowRouter.go tabManager.lastVisitedTab()
      else
        Router.go tabManager.lastVisitedTab()
