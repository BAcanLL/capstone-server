module SessionsHelper
  def get_token(user)
    token = nil
    if (user.class == Therapist)
      session = Session.find_by(therapist_id: user.id)
      if session.nil?
        session = Session.new(therapist_id: user.id, token: create_token)
        session.save!
      end
      token = session.token
    elsif (user.class == Patient)
      session = Session.find_by(patient_id: user.id)
      if session.nil?
        session = Session.new(patient_id: user.id, token: create_token)
        session.save!
      end
      token = session.token
    else
      raise "NANI"
    end
    token
  end

  def get_therapist(token)
    session = Session.find_by(token: token)
    return nil if session.nil?
    Therapist.find(session.therapist_id)
  end

  def get_patient(token)
    session = Session.find_by(token: token)
    return nil if session.nil?
    Patient.find(session.patient_id)
  end

  def create_token
    token = SecureRandom.hex(5) # or whatever you chose like UUID tools
    while Session.exists?(:token => token) do
      token = SecureRandom.hex(3) # or whatever you chose like UUID tools
    end
    token
  end
end