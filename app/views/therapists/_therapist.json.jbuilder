json.extract! therapist, :id, :email, :password_digest, :first_name, :last_name, :prefix, :profession, :created_at, :updated_at
json.url therapist_url(therapist, format: :json)
