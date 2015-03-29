describe 'Alphanumeric Test', () ->
  helper = new ValidatorTestHelper()
  helper.beforeEach('alphanumeric')

  it 'should fail on "!"', () ->
    helper.link()
    expect(helper.validate('!')).toBeFalsy()

  it 'should pass on "abc"', () ->
    helper.link()
    expect(helper.validate('abc')).toBeTruthy()

  it 'should pass on "2"', () ->
    helper.link()
    expect(helper.validate('2')).toBeTruthy()

  it 'should fail on "abc_-!"', () ->
    helper.link()
    expect(helper.validate('abc_-')).toBeFalsy()
