require 'test_helper'

class RootingTest < ActionDispatch::IntegrationTest

  test "routing test" do
    # root
    assert_generates '/', { controller: 'homes', action: 'main' }

    #users
    # TODO: must to do rooting test
    assert_generates '/signup', { controller: 'users', action: 'new' }
    # assert_routing({ controller: 'users', action: 'create'}, { path: 'users', method: :post })
    assert_routing '/users/1', { controller: 'users', action: 'show', id: '1'}
  end
end