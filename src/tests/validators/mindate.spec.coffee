describe 'Mindate Test', () ->
  helper = new ValidatorTestHelper()

  helper.beforeEach('mindate', [{
    key: 'dateHelper',
    fn: helper.getMockedDateHelper
  }])

  it 'should succeed when exceeding the mindate', () ->
    helper.link('data.minDate')
    helper.scope.data = { minDate: '2015-02-03' }
    expect(helper.validate('2015-02-05')).toBeTruthy()

  it 'should fail when preceding the mindate', () ->
    helper.link('data.otherDate')
    helper.scope.data = { otherDate: '2015-02-03' }
    expect(helper.validate('2015-02-02')).toBeFalsy()



