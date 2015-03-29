describe 'Accepted Test', () ->
  helper = new ValidatorTestHelper()
  helper.beforeEach('accepted')

  it 'should fail on "test"', () ->
    helper.link()
    expect(helper.validate('test')).toBeFalsy()

  it 'should pass on "true"', () ->
    helper.link()
    expect(helper.validate('true')).toBeTruthy()

  it 'should pass on "1"', () ->
    helper.link()
    expect(helper.validate( '1')).toBeTruthy()

  it 'should fail on "2"', () ->
    helper.link()
    expect(helper.validate('2')).toBeFalsy()
