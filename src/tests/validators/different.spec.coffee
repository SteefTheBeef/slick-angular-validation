describe 'Different Test', () ->
  helper = new ValidatorTestHelper()

  helper.beforeEach('different', [{
    key: 'valueHelper',
    fn: helper.getMockedValueHelper
  }])

  it 'should fail on "same" and "same"', () ->
    helper.link('data.otherValue')
    helper.scope.data = { otherValue: 'same' }
    expect(helper.validate('same')).toBeFalsy()

  it 'should succeed on "same" and "notsame"', () ->
    helper.link('data.otherValue')
    helper.scope.data = { otherValue: 'same' }
    expect(helper.validate('notsame')).toBeTruthy()

