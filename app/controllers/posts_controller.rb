class PostsController
  def initialize
    @view = PostsView.new
  end

  ################################################################
  # BEWARE: you MUST NOT use the global variable DB in this file #
  ################################################################

  def index
    # TODO: implement listing all posts
    # 1. Get the array of posts (CONTROLLLER HANDLES THE RETRIEVAL OF INFO FROM DB)
    posts = Post.all
    # 2. Display in the view (VIEW Handles the DISPLAY of data)
    @view.display_all(posts)
  end

  def create
    # 1. Ask the user for post.title and post.url (call the view)
    title = @view.ask_for_post_title
    url   = @view.ask_for_post_url
    # 2. Create an instance of a post with that information (Call .new)
    post = Post.new(title: title, url: url)
    # 3. Save that instance into thes database (Call the model method)
    post.save
  end

  def update
    # TODO: implement updating an existing post
    # 1. Display the posts
    posts = Post.all
    @view.display_all(posts)
    # 2. Ask the user for the specific id
    post = @view.ask_for_post_index(posts)
    # 3. Receive the values to update (title, url)
    new_attributes = @view.update_post
    # 5. Update the info for that instance
    post.title =  new_attributes[:title]
    post.url =  new_attributes[:url]

    # 6. Save into the database
    post.save
  end

  def destroy
    # TODO: implement destroying a post
    # Display the posts
    posts = Post.all
    @view.display_all(posts)
     
    # Ask for index/id
    post = @view.ask_for_post_index(posts)
    # delete that post 
    post.destroy
  end

  def upvote
    # TODO: implement upvoting a post

    posts = Post.all
    @view.display_all(posts)
     
    # Ask for index/id
    post = @view.ask_for_post_index(posts)
    # upvote by 1
    post.upvote
    # save
  end
end
