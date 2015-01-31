describe 'Different Test', () ->
  beforeEach () ->
    module 'angular-validate.rules'

  it 'should validate on 2009 and 2010', inject (different) ->
      expect(different.validate(2009, 2010)).toBeTruthy()

  it 'should not validate on 1 and 1', inject (different) ->
      expect(different.validate(1, 1)).toBeFalsy()

  it 'should validate on Aaa and aaa', inject (different) ->
    expect(different.validate('Aaa', 'aaa')).toBeTruthy()

  it 'should not validate on bbb and bbb', inject (different) ->
    expect(different.validate('bbb', 'bbb')).toBeFalsy()