json.data do
    json.partial! 'content', collection: @contents, as: :content
end