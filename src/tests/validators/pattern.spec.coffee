describe 'Pattern Test', () ->
  helper = new ValidatorTestHelper()

  helper.beforeEach('pattern', [{
    key: 'valueHelper',
    fn: helper.getMockedValueHelper
  }])

  it 'should fail when "aaaa" isnt in [0-9]', () ->
    helper.link('[0-9]')
    expect(helper.validate('aaaa')).toBeFalsy()

  it 'should succeed when "991122" is in [0-9]', () ->
    helper.link('\'[0-9]\'')
    expect(helper.validate('991122')).toBeTruthy()





