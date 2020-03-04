class Post
  attr_reader :id, :votes
  attr_accessor :title, :url

  def initialize(attrs = {})
    @url   = attrs[:url]
    @title = attrs[:title]
    @votes = attrs[:votes] ||= 0
    @id    = attrs[:id]
  end

  def self.all
    query = <<-SQL
      SELECT * FROM posts 
    SQL
    # [{id: 1, title: 'a', url: 'b', votes: 0 }]
    DB.results_as_hash = true
    # If we dont use results_as_hash this is the result of DB.execute = [[1, "a", "b", 0], [2, "a", "b", 0]]
    posts_as_db_values =  DB.execute(query)
    posts_as_db_values.map do |post_values|
      attrs = {
        title: post_values[:title],
        url: post_values[:url],
        votes: post_values[:votes],
        id: post_values[:id]
      }
      post = Post.new(attrs)
    end
  end

  def save
    query = if id.nil? 
              <<-SQL
                INSERT INTO posts (title, url, votes)
                VALUES ('#{title}', '#{url}', #{votes})
              SQL
            else
              <<-SQL
                UPDATE posts
                SET title = '#{title}' , url = '#{url}', votes = #{votes}
                WHERE id = #{id}
              SQL
            end
  
    DB.execute(query)
  end

  def destroy
    query = <<-SQL
      DELETE FROM posts WHERE id = #{id}
    SQL
    
    DB.execute(query)
  end

  def upvote
    @votes += 1

    save
  end
end