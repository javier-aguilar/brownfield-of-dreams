module Github
  class User
    attr_reader :id, :name, :url

    def initialize(id, name, url)
      @id = id
      @name = name
      @url = url
    end

    def friendable?(user_id)
      connected_to_github?(id) && (already_friends?(user_id, id) == false)
    end

    private

    def connected_to_github?(id)
      ::User.exists?(uid: id)
    end

    def already_friends?(user_id, friend_id)
      friend = ::User.find_by(uid: friend_id)
      Friendship.exists?(user_id: user_id, friend_id: friend.id)
    end
  end
end
