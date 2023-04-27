object @todo
attributes :id, :title, :description, :status, :created_at, :updated_at
node(:tags) { |todo| todo.tags.join(',') }
