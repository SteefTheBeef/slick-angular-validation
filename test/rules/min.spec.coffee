describe 'MaxLength Test', () ->
  beforeEach () ->
    module 'angular-validate.rules'

  it 'should validate 3 is larger than or equal to 2', inject (min) ->
      expect(min.validate('3', 2)).toBeTruthy()

  it 'should validate 2 is larger than or equal to 2', inject (min) ->
      expect(min.validate('2', 2)).toBeTruthy()

  it 'should not validate 1 is larger than or equal to 2', inject (min) ->
      expect(min.validate('1', 2)).toBeFalsy()

  it 'should return null on invalid number', inject (min) ->
      expect(min.validate('aaa', 1)).toBeNull()
