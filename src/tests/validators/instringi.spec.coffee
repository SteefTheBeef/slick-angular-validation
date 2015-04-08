describe 'Instringi Test', () ->
  helper = new ValidatorTestHelper()

  helper.beforeEach('instringi', [{
    key: 'valueHelper',
    fn: helper.getMockedValueHelper
  }])

  it 'should fail on "same" and "sake"', () ->
    helper.link('data.otherValue')
    helper.scope.data = { otherValue: 'same' }
    expect(helper.validate('sake')).toBeFalsy()

  it 'should succeed on "same" and "sA"', () ->
    helper.link('data.otherValue')
    helper.scope.data = { otherValue: 'same' }
    expect(helper.validate('sa')).toBeTruthy()

