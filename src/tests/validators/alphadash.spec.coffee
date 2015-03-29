describe 'Alphadash Test', () ->
  helper = new ValidatorTestHelper()
  helper.beforeEach('alphadash')

  it 'should fail on "!"', () ->
    helper.link()
    expect(helper.validate('!')).toBeFalsy()

  it 'should pass on "abc_"', () ->
    helper.link()
    expect(helper.validate('abc_')).toBeTruthy()

  it 'should pass on "2"', () ->
    helper.link()
    expect(helper.validate('2')).toBeTruthy()

  it 'should fail on "abc_-!"', () ->
    helper.link()
    expect(helper.validate('abc_-!')).toBeFalsy()
