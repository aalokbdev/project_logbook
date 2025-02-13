class CommentLog < InteractionLog
  validates :feedback, presence: true
end
