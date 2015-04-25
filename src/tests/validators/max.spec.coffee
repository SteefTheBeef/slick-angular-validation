describe 'Max Test', () ->
  helper = new ValidatorTestHelper()

  helper.beforeEach('max', [{
    key: 'valueHelper',
    fn: helper.getMockedValueHelper
  }])

  it 'should fail on 3 and 4', () ->
    helper.link('data.maxValue')
    helper.scope.data = { maxValue: '3' }
    expect(helper.validate('4')).toBeFalsy()

  it 'should succeed on 3 and 3', () ->
    helper.link('data.maxValue')
    helper.scope.data = { maxValue: '3' }
    expect(helper.validate('3')).toBeTruthy()

  it 'should succeed on 2 and 3, using another model', () ->
    helper.link('data.maxValue')
    helper.scope.data = { maxValue: '3' }
    expect(helper.validate('2')).toBeTruthy()

  it 'should succeed on 2 and 3, using a direct value', () ->
    helper.link('3')
    expect(helper.validate('2')).toBeTruthy()

  it 'should succeed on 2 and 3, using a direct value', () ->
    helper.link('\'3\'')
    expect(helper.validate('2')).toBeTruthy()


