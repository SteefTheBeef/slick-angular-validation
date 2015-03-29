describe 'Alpha Test', () ->
  helper = new ValidatorTestHelper()
  helper.beforeEach('alpha')

  it 'should fail on "!"', () ->
    helper.link()
    expect(helper.validate('!')).toBeFalsy()

  it 'should pass on "abc"', () ->
    helper.link()
    expect(helper.validate('abc')).toBeTruthy()

  it 'should fail on "2"', () ->
    helper.link()
    expect(helper.validate('2')).toBeFalsy()
