def most_recent_like
    Like.order("created_at").last
end
