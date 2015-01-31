describe 'AlphaDash Test', () ->
  beforeEach () ->
    module 'angular-validate.rules'

  it 'should validate on 99_', inject (alphaDash) ->
    expect(alphaDash.validate('99_')).toBeTruthy()

  it 'should validate on a', inject (alphaDash) ->
    expect(alphaDash.validate('1')).toBeTruthy()

  it 'should not validate on #', inject (alphaDash) ->
    expect(alphaDash.validate('#')).toBeFalsy()

  it 'should not validate on 9!', inject (alphaDash) ->
    expect(alphaDash.validate("9!")).toBeFalsy()

