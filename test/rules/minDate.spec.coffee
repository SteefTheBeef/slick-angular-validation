describe 'MinDate Test', () ->
  beforeEach () ->
    module 'angular-validate.rules'

  it 'should return null if any date is not a valid date', inject (minDate) ->
      expect(minDate.validate('aaa', '2013-01-01')).toBeNull()

  it 'should return null if any date is not a valid date', inject (minDate) ->
      expect(minDate.validate('2013-01-01', 'aaa v  ')).toBeNull()

  it 'should validate that 2013-02-02 is greater than 2013-02-01', inject (minDate) ->
      expect(minDate.validate('2013-02-02', '2013-02-01')).toBeTruthy()

  it 'should not validate when 2013-01-01 less th 2012-09-01', inject (minDate) ->
      expect(minDate.validate('2012-09-01', '2012-09-01')).toBeFalsy()