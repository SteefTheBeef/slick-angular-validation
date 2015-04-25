describe 'Maxlength Test', () ->
  helper = new ValidatorTestHelper()

  helper.beforeEach('maxlength', [{
    key: 'valueHelper',
    fn: helper.getMockedValueHelper
  }])

  it 'should fail when longer than maxlength', () ->
    helper.link('data.maxlength')
    helper.scope.data = { maxlength: 5 }
    expect(helper.validate('thisislongerthanfive')).toBeFalsy()

  it 'should fail when longer than maxlength', () ->
    helper.link('data.maxlength')
    helper.scope.data = { maxlength: '5' }
    expect(helper.validate('thisislongerthanfive')).toBeFalsy()

  it 'should succeed when shorter than maxlength', () ->
    helper.link('data.maxlength')
    helper.scope.data = { maxlength: '5' }
    expect(helper.validate('four')).toBeTruthy()


