class PostsView
  # TODO: implement methods called by the PostsController
  def display_all(posts)
    posts.each_with_index do |post, index|
      puts "#{index + 1} - title: #{post.title} url:(#{post.url},votes: #{post.votes} ,id: #{post.id})"
    end
  end

  def ask_for_post_title
    # 1. Ask the user for the title
    puts 'Please enter the post title:'
    print '>'
    # 2. get the user input 
    gets.chomp
  end

  def ask_for_post_url
    puts 'Please enter the post url:'
    print '>'
    gets.chomp
  end

  def ask_for_post_index(posts)
    puts 'what post do you want to edit?'
    print '>'
    posts[gets.chomp.to_i - 1]
  end

  def update_post
    puts 'enter the new title:'
    print '>'
    new_title = gets.chomp

    puts 'enter the new url:'
    print '>'
    new_url = gets.chomp
    { title: new_title, url: new_url }
  end
end
