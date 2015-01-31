describe 'MaxDate Test', () ->
  beforeEach () ->
    module 'angular-validate.rules'

  it 'should validate if any date is not a valid date', inject (maxDate) ->
      expect(maxDate.validate('aaa', '2013-01-01')).toBeTruthy()

  it 'should validate that 2013-01-01 is less than 2013-02-01', inject (maxDate) ->
      expect(maxDate.validate('2013-01-01', '2013-02-01')).toBeTruthy()

  it 'should not validate when 2013-01-01 is greater than 2012-09-01', inject (maxDate) ->
      expect(maxDate.validate('2013-01-01', '2012-09-01')).toBeFalsy()