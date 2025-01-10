require "test_helper"

class RegistriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @registry = registries(:one)
    host! "localhost:3000"
  end

  # Test for the `index` action
  test "should get index without filter" do
    get registries_url
    assert_response :success
    assert_not_nil assigns(:registries)
  end

  test "should get index with filter" do
    filter = "example_source"
    get registries_url, params: { filter: filter }
    assert_response :success
    assert_not_nil assigns(:registries)
    assert_includes response.body, filter
  end

  # Test for the `show` action
  test "should show registry" do
    get registry_url(@registry)
    assert_response :success
    assert_includes response.body, @registry.source
    assert_includes response.body, @registry.destination
  end

  # Test for the `create` action
  test "should create registry with valid params" do
    assert_difference('Registry.count') do
      post registries_url, params: { registry: { source: "New Source", destination: "New Destination", status: "active", confidential: false } }
    end
    assert_response :created
    assert_includes response.body, "New Source"
    assert_includes response.body, "New Destination"
  end


  # Test for the `update` action
  test "should update registry with valid status" do
    patch registry_url(@registry), params: { registry: { status: "inactive" } }
    assert_response :success
    @registry.reload
    assert_equal "inactive", @registry.status
  end

  test "should not update registry with invalid status" do
    patch registry_url(@registry), params: { registry: { status: "invalid_status" } }
    assert_response :unprocessable_entity
    puts "response body is "
    puts response.body
    assert_includes response.body, "Invalid status"
  end

  test "should update registry with valid params" do
    patch registry_url(@registry), params: { registry: { source: "Updated Source", destination: "Updated Destination" } }
    assert_response :success
    @registry.reload
    assert_equal "Updated Source", @registry.source
    assert_equal "Updated Destination", @registry.destination
  end

  # Test for the `destroy` action
  test "should destroy registry" do
    assert_difference('Registry.count', -1) do
      delete registry_url(@registry)
    end
    assert_response :no_content
  end
end
