describe 'Date Test', () ->
  helper = new ValidatorTestHelper()

  helper.beforeEach('date', [{
    key: 'dateHelper',
    fn: helper.getMockedDateHelper
  }])

  it 'should pass on "20134-12-01"', () ->
    helper.link()
    expect(helper.validate('20134-12-01')).toBeTruthy()

