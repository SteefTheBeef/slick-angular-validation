describe 'MaxLength Test', () ->
  beforeEach () ->
    module 'angular-validate.rules'

  it 'should validate that aaa is less or equal to 3 chars in length', inject (maxLength) ->
      expect(maxLength.validate('aaa', 3)).toBeTruthy()

  it 'should not validate that that aaaa is less or equal to 3 chars in length', inject (maxLength) ->
      expect(maxLength.validate('aaaa', 3)).toBeFalsy()