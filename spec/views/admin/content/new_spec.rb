require 'spec_helper'

describe "admin/content/new.html.erb" do
  describe "renders with our without resources" do
    before do
      admin = stub_model(User, :settings => {:editor => 'simple'}, :admin? => true,
                         :text_filter_name => "", :profile_label => "admin")
      blog = mock_model(Blog, :base_url => "http://myblog.net/")
      article = stub_model(Article).as_new_record
      text_filter = stub_model(TextFilter)

      article.stub(:text_filter) { text_filter }
      view.stub(:current_user) { admin }
      view.stub(:this_blog) { blog }
      
      # FIXME: Nasty. Controller should pass in @categories and @textfilters.
      Category.stub(:all) { [] }
      TextFilter.stub(:all) { [text_filter] }

      assign :article, article
    end

    it "renders with no resources or macros" do
      assign(:images, [])
      assign(:macros, [])
      assign(:resources, [])
      render
    end

    it "renders with image resources" do
      # FIXME: Nasty. Thumbnail creation should not be controlled by the view.
      img = mock_model(Resource, :filename => "foo", :create_thumbnail => nil)
      assign(:images, [img])
      assign(:macros, [])
      assign(:resources, [])
      render
    end
  end

  describe "displays the merge_with field to authorized users only" do
    before do
      @admin = stub_model(User, :settings => {:editor => 'simple'}, :admin? => true,
                         :text_filter_name => "", :profile_label => "admin")
      @writer = stub_model(User, :settings => {:editor => 'simple'}, :admin? => false,
                         :text_filter_name => "", :profile_label => "admin")
      blog = mock_model(Blog, :base_url => "http://myblog.net/")
      article = stub_model(Article).as_new_record
      text_filter = stub_model(TextFilter)

      article.stub(:text_filter) { text_filter }
      view.stub(:this_blog) { blog }

      # FIXME: Nasty. Controller should pass in @categories and @textfilters.
      Category.stub(:all) { [] }
      TextFilter.stub(:all) { [text_filter] }

      assign :article, article
      assign(:images, [])

      @target_field_tag = text_field_tag 'merge_with'
    end

    it 'should display a field named merge_with if user is an admininstrator' do
      view.stub(:current_user) { @admin }
      render
      rendered.should =~ /#{@target_field_tag}/
    end

    it 'should NOT display a field named merge_with if user is NOT an administrator' do
      view.stub(:current_user) { @writer }
      render
      rendered.should_not =~ /#{@target_field_tag}/
    end
  end
end
