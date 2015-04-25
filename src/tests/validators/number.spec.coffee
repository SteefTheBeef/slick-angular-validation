describe 'Number Test', () ->
  helper = new ValidatorTestHelper()

  helper.beforeEach('number')

  it 'should fail when "aaaa"', () ->
    helper.link()
    expect(helper.validate('aaaa')).toBeFalsy()

  it 'should fail on "a9"', () ->
    helper.link()
    expect(helper.validate('a9')).toBeFalsy()

  it 'should fail on "9a"', () ->
    helper.link()
    expect(helper.validate('9a')).toBeFalsy()

  it 'should succeed on "9"', () ->
    helper.link()
    expect(helper.validate('9')).toBeTruthy()

  it 'should succeed on "9.0"', () ->
    helper.link()
    expect(helper.validate('9.0')).toBeTruthy()

  it 'should fail on "9,0"', () ->
    helper.link()
    expect(helper.validate('9,0')).toBeFalsy()




