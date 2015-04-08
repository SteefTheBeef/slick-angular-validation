describe 'Email Test', () ->
  helper = new ValidatorTestHelper()

  helper.beforeEach('email')

  it 'should fail on "keke"', () ->
    helper.link()
    expect(helper.validate('keke')).toBeFalsy()

  it 'should fail on "keke@"', () ->
    helper.link()
    expect(helper.validate('keke@')).toBeFalsy()

  it 'should fail on "keke.@."', () ->
    helper.link()
    expect(helper.validate('keke.@.')).toBeFalsy()

  it 'should fail on "keke.com"', () ->
    helper.link()
    expect(helper.validate('keke.com')).toBeFalsy()

  it 'should succeed on "keke@keke.com"', () ->
    helper.link()
    expect(helper.validate('keke@keke.com')).toBeTruthy()


