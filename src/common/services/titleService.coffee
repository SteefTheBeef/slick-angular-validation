app.factory 'titleService', ($document) ->
  prefix = ''

  return {
    setPrefix: (p) -> prefix = p
    getPrefix: () -> prefix

    setTitle: ( t ) ->
      if prefix isnt ''
        title = prefix + t
      else
        title = t

      $document.prop 'title', title
      @title = t

    getTitle: () -> $document.prop 'title'
  }

