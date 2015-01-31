describe 'AlphaNumeric Test', () ->
  beforeEach () ->
    module 'angular-validate.rules'

  it 'should validate on 99', inject (alphaNumeric) ->
    expect(alphaNumeric.validate('99')).toBeTruthy()

  it 'should validate on ABC', inject (alphaNumeric) ->
    expect(alphaNumeric.validate('ABC')).toBeTruthy()

  it 'should not validate on Z1_', inject (alphaNumeric) ->
    expect(alphaNumeric.validate('Z1_')).toBeFalsy()

  it 'should not validate on !!', inject (alphaNumeric) ->
    expect(alphaNumeric.validate("!!")).toBeFalsy()

