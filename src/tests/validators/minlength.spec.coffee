describe 'Minlength Test', () ->
  helper = new ValidatorTestHelper()

  helper.beforeEach('minlength', [{
    key: 'valueHelper',
    fn: helper.getMockedValueHelper
  }])

  it 'should fail when shorter than minlength', () ->
    helper.link('data.minlength')
    helper.scope.data = { minlength: 5 }
    expect(helper.validate('four')).toBeFalsy()

  it 'should succeed when longer than minlength', () ->
    helper.link('data.minlength')
    helper.scope.data = { minlength: '5' }
    expect(helper.validate('thisislongerthanfive')).toBeTruthy()

  it 'should succeed when equal to minlength', () ->
    helper.link('data.minlength')
    helper.scope.data = { maxlength: '5' }
    expect(helper.validate('fours')).toBeTruthy()


