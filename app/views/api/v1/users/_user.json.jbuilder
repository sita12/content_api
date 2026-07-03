json.data do
  json.(user,
      :id
  )
  json.type "users"
  json.attributes do
    json.token token
    json.email user.email
    json.name user.name
    json.country user.country
    json.createdAt user.created_at
    json.updatedAt user.updated_at
  end
end
