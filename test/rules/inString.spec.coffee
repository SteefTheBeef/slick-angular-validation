describe 'InString Test', () ->
  beforeEach () ->
    module 'angular-validate.rules'

  it 'should validate on monkey in monkeyman', inject (inString) ->
      expect(inString.validate('monkey', 'monkeyman')).toBeTruthy()

  it 'should validate on test in Testing', inject (inString) ->
      expect(inString.validate('test', 'Testing')).toBeTruthy()

  it 'should not validate on test in monkey', inject (inString) ->
      expect(inString.validate('test', 'monkey')).toBeFalsy()