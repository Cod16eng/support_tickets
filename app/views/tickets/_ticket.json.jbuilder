json.extract! ticket, :id, :title, :description, :status, :priority, :user_id, :created_at, :updated_at
json.url ticket_url(ticket, format: :json)
