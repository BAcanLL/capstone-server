json.extract! patient, :id, :email, :password_digest, :first_name, :last_name, :height, :weight, :birthday, :created_at, :updated_at
json.url patient_url(patient, format: :json)
