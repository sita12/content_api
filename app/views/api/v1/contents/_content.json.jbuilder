json.(content,
    :id
)
json.type "content"
json.attributes do
    json.title content.title
    json.body content.body
    json.createdAt content.created_at
    json.updatedAt content.updated_at
end
