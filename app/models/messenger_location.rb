class MessengerLocation < ActiveRecord::Base
	belongs_to :user
	def testeo
		@algo=MessengerLocation.find(2)
		@algo.latitude=@algo.latitude+10
		@algo.save
	end
end
