describe 'Instring Test', () ->
  helper = new ValidatorTestHelper()

  helper.beforeEach('instring', [{
    key: 'valueHelper',
    fn: helper.getMockedValueHelper
  }])

  it 'should fail on "same" and "sake"', () ->
    helper.link('data.otherValue')
    helper.scope.data = { otherValue: 'same' }
    expect(helper.validate('sake')).toBeFalsy()

  it 'should succeed on "same" and "sa"', () ->
    helper.link('data.otherValue')
    helper.scope.data = { otherValue: 'same' }
    expect(helper.validate('sa')).toBeTruthy()

  it 'should fail on "same" and "sA"', () ->
    helper.link('data.otherValue')
    helper.scope.data = { otherValue: 'same' }
    expect(helper.validate('sA')).toBeFalsy()

