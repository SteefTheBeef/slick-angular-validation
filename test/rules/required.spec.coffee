describe 'Required Test', () ->
  beforeEach () ->
    module 'angular-validate.rules'

  it 'should not validate on null', inject (required) ->
    expect(required.validate(null)).toBeFalsy()

  it 'should not validate on empty string', inject (required) ->
    expect(required.validate(null)).toBeFalsy()

  it 'should not validate on undefined', inject (required) ->
    expect(required.validate(undefined)).toBeFalsy()

  it 'should validate a string', inject (required) ->
    expect(required.validate("Test")).toBeTruthy()

  it 'should validate a number', inject (required) ->
    expect(required.validate(2)).toBeTruthy()

