describe 'Email Test', () ->
  beforeEach () ->
    module 'angular-validate.rules'

  it 'should validate on test@test.com', inject (email) ->
      expect(email.validate('test@test.com')).toBeTruthy()

  it 'should validate on stefan.a@gdfgsdfgdf.com', inject (email) ->
      expect(email.validate('stefan.a@gdfgsdfgdf.com')).toBeTruthy()

  it 'should validate on stefan.a.b.c@h.j.ty.gdfgsdfgdf.com', inject (email) ->
      expect(email.validate('stefan.a.b.c@h.j.ty.gdfgsdfgdf.com')).toBeTruthy()