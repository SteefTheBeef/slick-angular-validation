describe 'Date Test', () ->
  beforeEach () ->
    module 'angular-validate.rules'

  it 'should validate on true', inject (date) ->
      expect(date.validate('2009')).toBeTruthy()

  it 'should validate on true', inject (date) ->
    expect(date.validate('2010-01-01')).toBeTruthy()

  it 'should validate on 1', inject (date) ->
    expect(date.validate('2010/01/02')).toBeTruthy()

  it 'should validate on 0', inject (date) ->
    expect(date.validate('2014-13-01')).toBeFalsy()