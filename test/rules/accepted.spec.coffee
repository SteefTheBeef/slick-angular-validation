describe 'Accepted Test', () ->
  beforeEach () ->
    module 'angular-validate.rules'

  it 'should validate on true', inject (accepted) ->
    expect(accepted.validate('true')).toBeTruthy()

  it 'should validate on 1', inject (accepted) ->
    expect(accepted.validate('1')).toBeTruthy()

  it 'should not validate on apa', inject (accepted) ->
    expect(accepted.validate('apa')).toBeFalsy()

  it 'should not validate on !!', inject (accepted) ->
    expect(accepted.validate("!!")).toBeFalsy()

