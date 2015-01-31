describe 'Match Test', () ->
  beforeEach () ->
    module 'angular-validate.rules'

  it 'should validate on monkey and monkey', inject (match) ->
      expect(match.validate('monkey', 'monkey')).toBeTruthy()

  it 'should not validate Monkey and monkey', inject (match) ->
      expect(match.validate('Monkey', 'monkey')).toBeFalsy()