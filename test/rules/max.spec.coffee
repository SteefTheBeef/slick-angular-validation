describe 'Max Test', () ->
  beforeEach () ->
    module 'angular-validate.rules'

  it 'should validate that 2 is less than 3', inject (max) ->
      expect(max.validate(2, 3)).toBeTruthy()

  it 'should validate on 2.3 and 2.4', inject (max) ->
      expect(max.validate('2.3', '2.4')).toBeTruthy()

  it 'should validate on 2.4 and 2.4', inject (max) ->
      expect(max.validate('2.4', '2.4')).toBeTruthy()

  it 'should not validate 2.5 and 2.4', inject (max) ->
      expect(max.validate('2.5', '2.4')).toBeFalsy()