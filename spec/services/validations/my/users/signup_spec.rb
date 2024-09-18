# frozen_string_literal: true

RSpec.describe Validations::My::Users::Signup do
  it "requires a name" do
    expect(subject.call({}).errors.to_h).to include(name: ["is missing"])
  end

  it "requires a surname" do
    expect(subject.call({name: 'john'}).errors.to_h).to include(surname: ["is missing"])
  end

  it "requires an email" do
    expect(
      subject.call(
        {
          name: 'john',
          surname: 'doe'
        }
      ).errors.to_h
    ).to include(email: ["is missing"])
  end

  it "requires a phone" do
    expect(
      subject.call(
        {
          name: 'john',
          surname: 'doe',
          email: 'johndoe@mail.com'
        }
      ).errors.to_h
    ).to include(phone: ["is missing"])
  end

  it "requires a password" do
    expect(
      subject.call(
        {
          name: 'john',
          surname: 'doe',
          email: 'johndoe@mail.com',
          phone: '123456789'
        }
      ).errors.to_h
    ).to include(password: ["is missing"])
  end

  it "requires a password confirmation" do
    expect(
      subject.call(
        {
          name: 'john',
          surname: 'doe',
          email: 'johndoe@mail.com',
          phone: '123456789',
          password: 'password'
        }
      ).errors.to_h
    ).to include(password_confirmation: ["is missing"])
  end

  it "requires the password and password confirmation to match" do
    expect(
      subject.call(
        {
          name: 'john',
          surname: 'doe',
          email: 'johndoe@mail.com',
          phone: '123456789',
          password: 'password',
          password_confirmation: 'not_password'
        }
      ).errors.to_h
    ).to include(password: ["passwords must match"])
  end
end
