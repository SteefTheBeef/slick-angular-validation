app.config( ($stateProvider, $urlRouterProvider) ->
  $stateProvider
  .state('main', { url: '/', displayName: 'Main view', views: main: controller: 'mainCtrl',   templateUrl: '/src/app/main/main.tpl.html'})
  .state('other', { url: '/other', displayName: 'Other view', views: main: controller: 'otherCtrl',   templateUrl: '/src/app/other/other.tpl.html'})

  $urlRouterProvider.otherwise('/')
)

.run( () ->

)
