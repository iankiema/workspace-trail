class ReservationSerializer
  include FastJsonapi::ObjectSerializer
  attributes :user_id, :package_id, :location, :date
end
