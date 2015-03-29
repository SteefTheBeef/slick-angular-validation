describe 'Boolean Test', () ->
  helper = new ValidatorTestHelper()
  helper.beforeEach('boolean')

  it 'should fail on "2"', () ->
    helper.link()
    expect(helper.validate('!')).toBeFalsy()

  it 'should pass on "true"', () ->
    helper.link()
    expect(helper.validate('true')).toBeTruthy()

  it 'should pass on "TrUe"', () ->
    helper.link()
    expect(helper.validate('TrUe')).toBeTruthy()

  it 'should pass on "false"', () ->
    helper.link()
    expect(helper.validate('false')).toBeTruthy()

  it 'should pass on "1"', () ->
    helper.link()
    expect(helper.validate('1')).toBeTruthy()

  it 'should pass on "0"', () ->
    helper.link()
    expect(helper.validate('0')).toBeTruthy()
