app.controller 'mainCtrl', ($scope) ->
  $scope.data = {
    name: 'Gulangco Plate'
  }

  $scope.modal = {
    "title": "Title",
    "content": "Hello Modal<br />This is a multiline message!"
  };

  $scope.aside = {
    "title": "Title",
    "content": "Hello Aside<br />This is a multiline message!"
  };

  $scope.alert = {
    "title": "Holy guacamole!",
    "content": "Best check yo self, you're not looking too good.",
    "type": "info"
  };