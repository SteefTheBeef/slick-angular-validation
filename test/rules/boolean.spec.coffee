describe 'Boolean Test', () ->
  beforeEach () ->
    module 'angular-validate.rules'

  it 'should validate on true', inject (boolean) ->
    expect(boolean.validate('true')).toBeTruthy()

  it 'should validate on true', inject (boolean) ->
    expect(boolean.validate(true)).toBeTruthy()

  it 'should validate on 1', inject (boolean) ->
    expect(boolean.validate('1')).toBeTruthy()

  it 'should validate on 1', inject (boolean) ->
    expect(boolean.validate(1)).toBeTruthy()

  it 'should validate on 0', inject (boolean) ->
    expect(boolean.validate(0)).toBeTruthy()

  it 'should validate on 0', inject (boolean) ->
    expect(boolean.validate('0')).toBeTruthy()

  it 'should validate on false', inject (boolean) ->
    expect(boolean.validate(false)).toBeTruthy()

  it 'should validate on False', inject (boolean) ->
    expect(boolean.validate('False')).toBeTruthy()

  it 'should not validate on apa', inject (boolean) ->
    expect(boolean.validate('apa')).toBeFalsy()

  it 'should not validate on !!', inject (boolean) ->
    expect(boolean.validate("!!")).toBeFalsy()

