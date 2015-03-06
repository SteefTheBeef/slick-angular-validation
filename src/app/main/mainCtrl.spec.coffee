describe 'MainCtrl Test', () ->
  beforeEach () ->
    module 'plate'

  it 'should validate on true', inject ($rootScope, $controller) ->
    scope = $rootScope.$new()
    $controller('mainCtrl', {$scope: scope })
    expect(scope.data.name).toBe('plate')