module PeopleHelper
  
  # returns a Hash of the form {person:Person => photo_asset:Sprockets::StaticAsset or nil}
  def get_photo_assets people
    Hash[ people.map do |person|
      [ person, Rails.application.assets.find_asset("photos/#{person.id}.jpg") ]
    end]
  end
  
end
