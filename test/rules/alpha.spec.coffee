describe 'Alpha Test', () ->
  beforeEach () ->
    module 'angular-validate.rules'

  it 'should validate on abc', inject (alpha) ->
    expect(alpha.validate('abc')).toBeTruthy()

  it 'should validate on ABC', inject (alpha) ->
    expect(alpha.validate('ABC')).toBeTruthy()

  it 'should not validate on abc!', inject (alpha) ->
    expect(alpha.validate('abc!')).toBeFalsy()

  it 'should not validate on 1', inject (alpha) ->
    expect(alpha.validate("1")).toBeFalsy()

