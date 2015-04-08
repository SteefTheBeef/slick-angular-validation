describe 'Matchi Test', () ->
  helper = new ValidatorTestHelper()

  helper.beforeEach('matchi', [{
    key: 'valueHelper',
    fn: helper.getMockedValueHelper
  }])

  it 'should fail on "same" and "sake"', () ->
    helper.link('data.otherValue')
    helper.scope.data = { otherValue: 'same' }
    expect(helper.validate('sake')).toBeFalsy()

  it 'should succeed on "same" and "same"', () ->
    helper.link('data.otherValue')
    helper.scope.data = { otherValue: 'same' }
    expect(helper.validate('same')).toBeTruthy()

  it 'should succeed on "samE" and "same"', () ->
    helper.link('data.otherValue')
    helper.scope.data = { otherValue: 'samE' }
    expect(helper.validate('same')).toBeTruthy()

