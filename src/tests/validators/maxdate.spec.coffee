describe 'Maxdate Test', () ->
  helper = new ValidatorTestHelper()

  helper.beforeEach('maxdate', [{
    key: 'dateHelper',
    fn: helper.getMockedDateHelper
  }])

  it 'should succeed when preceding the maxdate', () ->
    helper.link('data.otherDate')
    helper.scope.data = { otherDate: '2015-02-03' }
    expect(helper.validate('2015-02-02')).toBeTruthy()

  it 'should succeed when preceding the maxdate', () ->
    helper.link('data.otherDate')
    helper.scope.data = { otherDate: '2015-02-03 00:00:00' }
    expect(helper.validate('2015-02-02 00:00:00')).toBeTruthy()

  it 'should fail when exceeding the maxdate', () ->
    helper.link('data.otherDate')
    helper.scope.data = { otherDate: '2015-02-03 00:00:00' }
    expect(helper.validate('2015-02-04 00:00:00')).toBeFalsy()

  it 'should fail when exceeding the maxdate', () ->
    helper.link('data.otherDate')
    helper.scope.data = { otherDate: '2015-01-01' }
    expect(helper.validate(new Date())).toBeFalsy()


