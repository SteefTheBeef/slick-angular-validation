describe 'Min Test', () ->
  helper = new ValidatorTestHelper()

  helper.beforeEach('min', [{
    key: 'valueHelper',
    fn: helper.getMockedValueHelper
  }])

  it 'should fail when below min value', () ->
    helper.link('data.minValue')
    helper.scope.data = { minValue: '3' }
    expect(helper.validate('2')).toBeFalsy()

  it 'should succeed when equal to min value', () ->
    helper.link('data.minValue')
    helper.scope.data = { minValue: '3' }
    expect(helper.validate('3')).toBeTruthy()

  it 'should succeed when greater than min value', () ->
    helper.link('data.minValue')
    helper.scope.data = { minValue: '3' }
    expect(helper.validate('4')).toBeTruthy()



