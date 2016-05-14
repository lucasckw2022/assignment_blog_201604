require 'rails_helper'

RSpec.describe PostsController, type: :controller do

  # let(:new_post) {FactoryGirl.create(:post)}
  def new_post
  @new_post ||= FactoryGirl.create(:post)
  end

  describe "#new" do
    before {get :new}
    it "renders the new template" do
      expect(response).to render_template(:new)
    end
    it "assigns a campaign object" do
      #:post is getting from the controller @post
      expect(assigns(:post)).to be_a_new(Post)
    end
  end

  describe "#create" do
    describe "with valid attributes" do
      def post_valid
        post :create,
        #attributes_for is to create required field
        post: FactoryGirl.attributes_for(:post)
        # this is to create post with all required fields, same as below
        # post: {title: "asjdfosiad", body:"joiasdfjasd"}
      end
      it "saves a record to the database"do
        count_before = Post.count
        post_valid
        count_after = Post.count
        expect(count_after).to eq(count_before +1)
      end
      it "redirects to the campaign's show page"do
        post_valid
        expect(response).to redirect_to(post_path(Post.last))
      end
      it "sets a flash message" do
        post_valid
        expect(flash[:notice]).to be_present
      end
    end
    describe "with invalid attributes" do
      def post_invalid
        post :create, post:{body:"asjdfsoij"}
      end
      it "renders the new template"do
        post_invalid
        expect(response).to render_template(:new)
      end
      it "sets an alert message" do
        post_invalid
        expect(flash[:notice]).to be_present
      end
      it "doesn't save a record to the database" do
        count_before = Post.count
        post_invalid
        count_after = Post.count
        expect(count_after).to eq(count_before)
      end
    end
  end

  describe "#show" do
    before do
      get :show,
       id: new_post.id
     end
    it "renders the show template" do
      expect(response).to render_template(:show)
    end

    it "sets a campaign instance variable" do
      #assign the instance variable from controller and compare to the newly generated post in RSpec
      expect(assigns(:post)).to eq(new_post)
    end

  end

  describe "#index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end
    it "assigns an instance variable to all campaigns in the DB"do
    #create new record and see if index could assign them
      c = new_post
      c1 = new_post
      get :index
      expect(assigns(:posts)).to eq([c,c1])
    end
  end

  describe "#edit" do
    it "renders the edit template"
    it "sets an instance varible with the passed id"
  end

  describe "#update" do
    describe "with valid params" do
      it "updates the record whose id is passed"
      it "redirects to show page"
      it "sets a flash notice message"
    end
    describe "with invalid params" do
      it "doesnt update the record "
      it "render the edit template"
    end
  end

  describe "#destroy" do
    it "removes the campaign from the database"
    it "redirect to the index page"
    it "sets a flash"
  end

end
