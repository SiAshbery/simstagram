def most_recent_comment
  Comment.order("created_at").last
end
