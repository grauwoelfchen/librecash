require 'test_helper'

class NotesControllerTest < ActionController::TestCase
  locker_room_fixtures(:teams, :users, :mateships)
  fixtures(:notes)

  def setup
    Note.public_activity_off
  end

  def teardown
    Note.public_activity_on
  end

  def test_get_index
    user = locker_room_users(:oswald)
    team = user.teams.first
    within_subdomain(team.subdomain) do
      login_user(user)
      get(:index)
      refute_empty(assigns[:notes])
      assert_template(:index)
      assert_response(:success)
      logout_user
    end
  end

  def test_get_filtered_index_with_tag
    user = locker_room_users(:oswald)
    team = user.teams.first
    note = notes(:favorite_song)
    note.tag_list.add('Favorites')
    note.save
    within_subdomain(team.subdomain) do
      login_user(user)
      get(:index, :t => 'Favorites')
      assert_equal([note], assigns[:notes])
      assert_template(:index)
      assert_response(:success)
      logout_user
    end
  end

  def test_get_show
    user = locker_room_users(:oswald)
    team = user.teams.first
    within_subdomain(team.subdomain) do
      login_user(user)
      note = notes(:favorite_song)
      get(:show, :id => note.id)
      assert_equal(note, assigns[:note])
      assert_template(:show)
      assert_response(:success)
      logout_user
    end
  end

  def test_get_new
    user = locker_room_users(:oswald)
    team = user.teams.first
    within_subdomain(team.subdomain) do
      login_user(user)
      get(:new)
      assert_kind_of(Note, assigns[:note])
      assert_template(:new)
      assert_template(:partial => '_form')
      assert_response(:success)
      logout_user
    end
  end

  def test_post_create_with_validation_errors
    user = locker_room_users(:oswald)
    team = user.teams.first
    within_subdomain(team.subdomain) do
      login_user(user)
      params = {
        :note => {
          :title => ''
        }
      }
      assert_no_difference('Note.count', 1) do
        post(:create, params)
      end
      assert_instance_of(Note, assigns[:note])
      refute(assigns[:note].persisted?)
      assert_nil(flash[:notice])
      assert_template(:new)
      assert_template(:partial => 'shared/_error')
      assert_template(:partial => '_form')
      assert_response(:success)
      logout_user
    end
  end

  def test_post_create
    user = locker_room_users(:oswald)
    team = user.teams.first
    within_subdomain(team.subdomain) do
      login_user(user)
      params = {
        :note => {
          :title => 'New note'
        }
      }
      assert_difference('Note.count', 1) do
        post(:create, params)
      end
      assert_instance_of(Note, assigns[:note])
      assert(assigns[:note].persisted?)
      assert_equal(
        'Note has been successfully created.',
        ActionController::Base.helpers.strip_tags(flash[:notice])
      )
      assert_response(:redirect)
      assert_redirected_to(assigns[:note])
      logout_user
    end
  end

  def test_get_edit
    user = locker_room_users(:oswald)
    team = user.teams.first
    within_subdomain(team.subdomain) do
      login_user(user)
      note = notes(:favorite_song)
      get(:edit, :id => note.id)
      assert_equal(note, assigns[:note])
      assert_template(:edit)
      assert_template(:partial => '_form')
      assert_response(:success)
      logout_user
    end
  end

  def test_put_update_with_validation_errors
    user = locker_room_users(:oswald)
    team = user.teams.first
    within_subdomain(team.subdomain) do
      login_user(user)
      note = notes(:favorite_song)
      params = {
        :id   => note.id,
        :note => {
          :title => ''
        }
      }
      put(:update, params)
      assert_equal(note, assigns[:note])
      assert_nil(flash[:notice])
      assert_template(:edit)
      assert_template(:partial => 'shared/_error')
      assert_template(:partial => '_form')
      assert_response(:success)
      logout_user
    end
  end

  def test_put_update
    user = locker_room_users(:oswald)
    team = user.teams.first
    within_subdomain(team.subdomain) do
      login_user(user)
      note = notes(:favorite_song)
      params = {
        :id   => note.id,
        :note => {
          :title => 'Violin note'
        }
      }
      put(:update, params)
      assert_equal(params[:note][:title], assigns[:note].title)
      assert_equal(
        'Note has been successfully updated.',
        ActionController::Base.helpers.strip_tags(flash[:notice])
      )
      assert_response(:redirect)
      assert_redirected_to(assigns[:note])
      logout_user
    end
  end

  def test_delete_destroy
    user = locker_room_users(:oswald)
    team = user.teams.first
    within_subdomain(team.subdomain) do
      login_user(user)
      note = notes(:favorite_song)
      assert_difference('Note.count', -1) do
        delete(:destroy, :id => note.id)
      end
      assert_equal(note, assigns[:note])
      refute(assigns[:note].persisted?)
      assert_equal(
        'Note has been successfully destroyed.',
        ActionController::Base.helpers.strip_tags(flash[:notice])
      )
      assert_response(:redirect)
      assert_redirected_to(notes_url)
      logout_user
    end
  end
end
